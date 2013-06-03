class UserMailer < ActionMailer::Base
  default :from => "ajhbasdjg@gmail.com"
 
  def checkout_email(user, order, id)
    @user = user
    @order = order
    @link_detail = 'http://0.0.0.0:3000/order/'+id
    @url  = "http://localhost:3000"
    mail(:to => user.email,
      :subject => 'Order detail')
  end


  def send_mail_resetpassword(user, link)
    @user = user
    @link = link
    mail(:to => @user,
      :subject => 'Reset your password')
  end  


end
