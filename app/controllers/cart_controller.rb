class CartController <ApplicationController

	def index
		@cart = session[:cart] || {}
	end

	def addcart
		pid = params[:pid]
		product = Products.find(pid)

		cart = session[:cart] ||= {}
		cart[pid] = (cart[pid] || 0) + 1

		html = session[:cart].count
		render :text => html
	end

	def deletecart
		pid = params[:pid]
		session[:cart].delete(pid)
		render :text => ""
	end

	def unsetcart
		session[:cart] = nil
		render :text => ""
	end
end
