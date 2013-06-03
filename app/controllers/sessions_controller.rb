class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or root_path
		else
			flash.now[:error] = 'Invalid email/password'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	def email_request

  end

  def send_token
    if params[:session].nil? || params[:session][:email].nil?
      flash[:notice_email_request] = 'email cant be blank'
      return render "email_request"
    end
    email_request = params[:session][:email]
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    if !email_request.match email_regex
      flash[:notice_email_request] = 'invalid email'
      return render "email_request"
    end

    account  = User.where(:email => email_request).first

    unless account.nil?
      user = account
      if user.nil?
        flash[:notice_email_request] = 'email_not_exist'
        @class = "alert alert-error"
        return render "email_request"
      else
        new_token = SecureRandom.urlsafe_base64
        if account.role == 'user'
          account.update_attributes( :remember_token =>  new_token)
          username = user.name
          server_url = request.protocol+request.host_with_port
          url_confirm = "#{server_url}/reminder/update?token=#{new_token}&id=#{account.id}"
          flash[:send_password] = 'send confirm password'
          begin
            UserMailer.send_mail_resetpassword(email_request,url_confirm).deliver
            redirect_to '/signin'
          rescue
            flash[:notice_email_request] = (t "login_form.error_email_system")
            return render "email_request"
          ensure
          end
        end
      end
    else
      flash[:notice_email_request] = 'email not exist'
      return render "email_request"
    end
  end


  def update_pass
    if (!params[:token].nil? && !params[:id].nil?)
      @token    = params[:token]
      @id       = params[:id]
      account = User.where(:id => @id, :remember_token => @token).first
      unless account.nil?
        #### post from form input new pass
        if !params[:post_new_pass].nil?
          #### validate password
          new_pass         = params[:acc_new_pass].strip
          new_pass_confirm = params[:acc_new_pass_confirm].strip
          if new_pass.to_s.blank?
            @class = "alert-error"
            @msg = (t "remind.pwblank")
            return render  "account_new_password"
          elsif new_pass.to_s.length < 8
            @class = "alert-error"
            @msg = (t "remind.pwtooshort")
            return render  "account_new_password"
          elsif new_pass.match(/\W+/)
            @class = "alert-error"
            @msg = (t "remind.pwinvalid")
            return render  "account_new_password"
          elsif !new_pass.match(/\d+/) || !new_pass.match(/[a-z]/)
            @class = "alert-error"
            @msg = (t "remind.pwinvalid")
            return render  "account_new_password"
          elsif new_pass != new_pass_confirm
            @class = "alert-error"
            @msg = (t "remind.pwnotmatch")
            return render  "account_new_password"
          else
            account.update_attributes(:password   =>  new_pass, :remember_token =>  SecureRandom.urlsafe_base64)
            account.save
            @class = "alert-success"
            @msg = "success"
            return render  "new"
          end
        else
          return render  "account_new_password"
        end
      else
        ### error token or email adrress
        @class = "alert-error"
        @msg = "author"
        return render  "new"
      end
    else
      return render 'new'
    end
  end


end
