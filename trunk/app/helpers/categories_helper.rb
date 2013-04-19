module CategoriesHelper

	def categories_menu()
		@categories = Categories.all
	end

	def new_product(count)
		@newproducts = Products.all
		@newproducts = @newproducts.sort_by(&:created_at).reverse
		@newproducts = @newproducts.take(count)
	end
end