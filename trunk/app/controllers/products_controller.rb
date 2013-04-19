class ProductsController <ApplicationController

	def index
		redirect_to categories_path
	end

	def show
		@product = Products.find(params[:id])
		@other_product = Products.where("id != ? AND category_id = ?", @product.id, @product.category_id)
		@other_product = @other_product.take(8)
	end

	def new
		@product = Products.new
	end

	def create
		@product = Products.new(params[:products])
		@product.user_id = current_user.id
		if @product.save
			flash[:success] = "Post success!"
			redirect_to posted_path
		else
			flash[:error] = "Please check info again!"
			redirect_to post_path
		end
	end

	def edit
		@product = Products.find(params[:id])
		if !(@product.user_id == current_user.id)
			flash[:error] = "Sorry! No permission!"
			redirect_to posted_path
		end
		@categories = Categories.all
	end

	def update
		@product = Products.find(params[:id])
		if @product.update_attributes(params[:products])
			flash[:success] = "Update Success!"
			redirect_to posted_path
		else
			render 'edit'
		end
	end

	def posted
		@my_pro  = Products.where("user_id = ?", current_user.id)
		@my_pro = @my_pro.paginate page: params[:page], order: 'created_at desc', per_page: 12
	end

	def destroy
		product = Products.find(params[:id])
		if !(product.user_id == current_user.id)
			flash[:error] = "Sorry! No permission!"
			redirect_to posted_path
		else
			product.destroy
		    flash[:success] = "Item deleted!"
		    redirect_to posted_path
		end
	end

end