class UsersController <ApplicationController
	before_filter :signed_in_user, 
	only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :correct_user,   only: [:edit, :update]

	def index
		if signed_in?
			redirect_to edit_user_path(current_user)
		else
			redirect_to root_path
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		@user.create_remember_token()
		if @user.save
			redirect_to @user
		else
			flash[:error] = "Invalid email/password"
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		if @user.update_attributes(params[:user],:remember_token =>  SecureRandom.urlsafe_base64)
			flash[:success] = "Update Success!"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	private

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in."
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

end