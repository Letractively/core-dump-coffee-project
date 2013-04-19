class OrderController <ApplicationController

	def index
		@order = Order.where("email = ?", current_user.email)
		@order = @order.paginate page: params[:page], order: 'created_at desc', per_page: 20
	end

	def show
		@order = Order.find(params[:id])
		if (@order.email == current_user.email)
			@detail = OrderDetail.where("order_id = ?", @order.id)
		else
			flash[:error] = "Not for you"
			redirect_to "/order"
		end
	end

	def new
		@order = Order.new
		@total = 0
		session[:cart].each do | id, quantity |
			item = Products.find_by_id(id)
			@total += quantity * item.price
		end
	end

	def create
		@order = Order.new(params[:order])
		total = 0
		if signed_in?
			@order.email = current_user.email
			cart = session[:cart]
			cart.each do | id, quantity |
				item = Products.find_by_id(id)
				total += quantity * item.price
			end

			@order.total = total
			if @order.save
				session[:cart].each do | id, quantity |
					item = Products.find_by_id(id)
					@detail = OrderDetail.new(order_id: @order.id, product_id: item.id, qrt: quantity)
					@detail.save
				end
				@user = current_user
				UserMailer.checkout_email(@user, session[:cart]).deliver
				session[:cart] = nil
				flash[:success] = "Success! We sent mail order confirmation to you."
				redirect_to root_path
			else
				render "new"
			end
		else
			flash[:error] = "Please login"
			render "new"
		end
	end

end