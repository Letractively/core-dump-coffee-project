class HomeController < ApplicationController
	def home
		@newproducts  = Products.where("user_id = 0")
		@newproducts = @newproducts.sort_by(&:created_at).reverse
		@newproducts = @newproducts.take(12)

		@userproducts = Products.where("user_id > 0")
		@userproducts = @userproducts.sort_by(&:created_at).reverse
		@userproducts = @userproducts.take(8)

	end
end