module UserMailer
  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    print('before send email')
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    print('after send email')
  end

  def test_my_mailer(user)
    @user = user
    print('test ok')
    print(@user)
  end

  def notify_email(order)
    @order = order
    @user = @order.user
    nickname = @order.user.nickname
    product = @order.product.title
    email = @user.email
    seller = @order.product.user.nickname
    seller_email = @order.product.user.email

    subject = '通知'
    body = <<EOF
尊敬的 #{nickname}：
<br>
您购买的商品#{product}，卖家已经成功确认。
<br>
请和卖家"#{seller}"进行邮件联系。卖家的邮件是#{seller_email}。
<br>
THUPOST小组
EOF

    `echo "#{body}" | mail -s "#{subject}" #{email}`
  end
end
