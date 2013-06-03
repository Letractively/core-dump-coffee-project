class CategoriesController <ApplicationController

	def index
		@newproducts = Products.all.sort_by(&:created_at).reverse
		@newproducts = @newproducts.paginate page: params[:page], per_page: 12
	end

	def show
		@cate = Categories.find(params[:id])
		@cate_pro  = Products.where("category_id = ?", @cate.id)
		@cate_pro = @cate_pro.paginate page: params[:page], order: 'created_at desc', per_page: 12
	end

end