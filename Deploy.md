# 安装imagemagick 配置config/enviroment里面的路径
# sqlite 
### 安装 Nginx

```
$ sudo apt-get install nginx
```

### 配置 Unicorn

编译静态文件：

```
$ RAILS_ENV=production rake assets:clean
$ RAILS_ENV=production rake assets:precompile
```

Unicorn 配置文件：

```
worker_processes 2
timeout 30

APP_PATH = File.expand_path("../..", __FILE__)
working_directory APP_PATH

listen 8080, :tcp_nopush => true
listen "/tmp/unicorn.sock", :backlog => 64

stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

pid APP_PATH + "/tmp/pids/unicorn.pid"
```

Unicorn 自启动脚本`unicorn_init.sh`

```
#!/bin/sh
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/var/www/thupost
APP_USER=root
PID=$APP_ROOT/tmp/pids/unicorn.pid
CMD="unicorn_rails -D -E production -c $APP_ROOT/config/unicorn.rb"
action="$1"
set -u

old_pid="$PID.oldbin"

cd $APP_ROOT || exit 1

sig () {
        test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
        test -s $old_pid && kill -$1 `cat $old_pid`
}

case $action in
start)
        sig 0 && echo >&2 "Already running" && exit 0
        su -c "$CMD" - $APP_USER
        ;;
stop)
        sig QUIT && exit 0
        echo >&2 "Not running"
        ;;
force-stop)
        sig TERM && exit 0
        echo >&2 "Not running"
        ;;
restart|reload)
        sig HUP && echo reloaded OK && exit 0
        echo >&2 "Couldn't reload, starting '$CMD' instead"
        su -c "$CMD" - $APP_USER
        ;;
upgrade)
        if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
        then
                n=$TIMEOUT
                while test -s $old_pid && test $n -ge 0
                do
                        printf '.' && sleep 1 && n=$(( $n - 1 ))
                done
                echo

                if test $n -lt 0 && test -s $old_pid
                then
                        echo >&2 "$old_pid still exists after $TIMEOUT seconds"
                        exit 1
                fi
                exit 0
        fi
        echo >&2 "Couldn't upgrade, starting '$CMD' instead"
        su -c "$CMD" - $APP_USER
        ;;
reopen-logs)
        sig USR1
        ;;
*)
        echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
        exit 1
        ;;
esac
```

将其在/etc/init.d/下做一个软连接，并使其开机自启动

```
$ chmod +x /var/www/thupost/unicorn_init.sh
$ sudo ln -s /var/www/thupost/unicorn_init.sh /etc/init.d/unicorn
$ sudo update-rc.d unicorn defaults
```

启动 Unicorn

```
$ service unicorn start
```

### 配置 Nginx

Nginx 配置文件`/etc/nginx/sites-available/thupost`：

```
upstream unicorn {
    server unix:/tmp/unicorn.sock fail_timeout=0;
}

gzip  on;
gzip_disable "msie6";
client_max_body_size 150m;

server {
    listen 80 default;
    return 403;
}

server {
    listen 80;
    server_name thupost.org;

    root /var/www/thupost;

    try_files $uri/index.html $uri.html $uri @httpapp;

    location @httpapp {
        proxy_redirect     off;
        proxy_set_header   Host $host;
        proxy_set_header   X-Forwarded-Host $host;
        proxy_set_header   X-Forwarded-Server $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_buffering    on;

        proxy_pass http://unicorn;
    }

    location ~ ^(/assets) {
        access_log  off;
        expires     max;
    }
}
```

在`sites-enabled`目录下创建软链接

```
sudo ln -s /etc/nginx/sites-available/thupost /etc/nginx/sites-enabled/thupost
```

重启 Nginx

```
sudo service nginx restart
```
