class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"
  layout 'mailer'
  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: user.email, subject: 'Thank-you for your order')
  end
end
