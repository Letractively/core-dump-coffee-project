class UserMailer < ActionMailer::Base
  default :from => "hieulh@zigexn.vn"
 
  def checkout_email(user, order)
    @user = user
    @order = order
    @url  = "http://localhost:3000"
    mail(:to => user.email, :subject => "Received your order from localhost")
  end
end
