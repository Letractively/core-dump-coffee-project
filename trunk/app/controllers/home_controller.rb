class HomeController < ApplicationController
	def home
		@newproducts  = Products.all
		@newproducts = @newproducts.sort_by(&:created_at).reverse
		@newproducts = @newproducts.paginate page: params[:page], per_page: 12

	end
end