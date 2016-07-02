require 'net/http'
require 'digest/md5'

module SendText

  def gen_signature(params)
    str = 'd4ef01db66c111128f05fc68d3e5a4ea'
    params.sort.each do |k, v|
      str += "#{k}#{v}"
    end
    str += 'd4ef01db66c111128f05fc68d3e5a4ea'
    (Digest::MD5.hexdigest str).upcase
  end

  # str -> Response
  def send_test_text(phone_number)
    uri = URI 'https://eco.taobao.com/router/rest'
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    post_params = {
        :method => 'alibaba.aliqin.fc.sms.num.send',
        :app_key => '23358998',
        :timestamp => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        :v => '2.0',
        :format => 'json',
        :sign_method => 'md5',
        :sms_type => 'normal',
        :sms_free_sign_name => '变更验证',
        :rec_num => phone_number,
        :sms_template_code => 'SMS_7441101',
        :sms_param => '{"code":"123456", "product":"THUPOST"}'
    }
    post_params[:sign] = gen_signature post_params

    http.post(uri, URI.encode_www_form(post_params))
  end

  def send_notify_text(order)
    uri = URI 'https://eco.taobao.com/router/rest'
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    @order = order
    product = @order.product.title
    phone_number = @order.user.phone
    @seller = @order.product.user
    user_phone = @seller.phone
    user_email = @seller.email

    post_params = {
        :method => 'alibaba.aliqin.fc.sms.num.send',
        :app_key => '23358998',
        :timestamp => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        :v => '2.0',
        :format => 'json',
        :sign_method => 'md5',
        :sms_type => 'normal',
        :sms_free_sign_name => '变更验证',
        :rec_num => phone_number,
        :sms_template_code => 'SMS_10805288',
        :sms_param => "{\"product\":\"#{product}\",\"user_phone\":\"#{user_phone}\",\"user_email\":\"#{user_email}\"}"
    }
    post_params[:sign] = gen_signature post_params

    print(post_params)
    r = http.post(uri, URI.encode_www_form(post_params))
    print(r.body)
  end
end
