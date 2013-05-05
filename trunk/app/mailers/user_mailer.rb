require 'mail'
class UserMailer < ActionMailer::Base
  default :from => 'admin@venshop.com'
 
  def checkout_email(user, order)
    @user = user
    @order = order
    @url  = "http://localhost:3000"
    mail(:to => user.email, :subject => "Received your order from localhost")
  end

  def send_mail(to,subject,body,addfile)
    Mail.deliver do
      from    :from
      to      to
      subject subject
      body    body
      add_file addfile if addfile
    end
  end

  def welcome(to)
     @url = 'http://localhost:3000'
     @to = to
     mail(:to => @to, :subject => 'Welcome to Venshop')
  end
end
