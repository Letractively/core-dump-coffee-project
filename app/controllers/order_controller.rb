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


		unless signed_in?
			redirect_to '/signin'
		else
			@order = Order.new
			@order.name   = current_user.name
			@order.address = current_user.address
			@order.phone = current_user.phonenum
			@total = 0
			session[:cart].each do | id, quantity |
				item = Products.find_by_id(id)
				@total += quantity * item.price
			end
		end
	end

	def create
		unless signed_in?
			redirect_to '/signin'
		else
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
					UserMailer.checkout_email(@user, session[:cart],@order.id.to_s).deliver
					session[:cart] = nil
					flash[:success] = (t 'successcheckout')
					redirect_to root_path
				else
					render "new"
				end
			else
				redirect_to '/signin'
			end
		end
	end


end