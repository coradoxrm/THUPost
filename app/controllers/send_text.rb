require 'net/http'
require 'digest/md5'

module SendText

  def gen_signature(params)
    str = ENV['ALI_TEXT_APP_SECRET']
    params.sort.each do |k, v|
      str += "#{k}#{v}"
    end
    str += ENV['ALI_TEXT_APP_SECRET']
    (Digest::MD5.hexdigest str).upcase
  end

  # str -> Response
  def send_test_text(phone_number)
    uri = URI 'https://eco.taobao.com/router/rest'
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    post_params = {
        :method => 'alibaba.aliqin.fc.sms.num.send',
        :app_key => ENV['ALI_TEXT_APP_KEY'],
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

    post_params = {
        :method => 'alibaba.aliqin.fc.sms.num.send',
        :app_key => ENV['ALI_TEXT_APP_KEY'],
        :timestamp => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        :v => '2.0',
        :format => 'json',
        :sign_method => 'md5',
        :sms_type => 'normal',
        :sms_free_sign_name => '变更验证',
        :rec_num => phone_number,
        :sms_template_code => 'SMS_10150867',
        :sms_param => "{\"product\":\"#{product}\"}"
    }
    post_params[:sign] = gen_signature post_params

    http.post(uri, URI.encode_www_form(post_params))
  end
end
