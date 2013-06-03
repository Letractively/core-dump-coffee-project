class AdminController < ApplicationController
	include ApplicationHelper
	
	def index
		unless isAdmin?
			redirect_to root_path
		else
			@category = Categories.new
			@products = []
			@id = 0
			if params[:categories]
				@id = params[:categories]['id']
				@products  = Products.where(:category_id => params[:categories]['id'])
			else 
				if params['id']
					@id = params['id']
					@products  = Products.where(:category_id => @id)
				end
			end
			@products = @products.paginate page: params[:page], order: 'created_at desc', per_page: 12
		end
	end

	def product_new
		unless isAdmin?
			redirect_to root_path
		else
			@product = Products.new
		end
	end

	def category_new
		unless isAdmin?
			redirect_to root_path
		else
			@category = Categories.new
		end
	end

	def category_create
		unless isAdmin?
			redirect_to root_path
		else
			@category = Categories.new(params[:categories])
			if @category.save
				flash[:success] = "Post success!"
			end
			@category = Categories.all
			@category = @category.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'categories'
		end
	end

	def product_create
		unless isAdmin?
			redirect_to root_path
		else
			@product = Products.new(params[:products])
			@product.user_id = current_user.id
			if @product.save
				flash[:success] = "Post success!"
			end
			@category = Categories.new
			@products = []
			@products = @products.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'index'
		end	
	end

	def product_edit
		unless isAdmin?
			redirect_to root_path
		else
			@product =  Products.find(params['id'])
		end
	end

	def product_save
		unless isAdmin?
			redirect_to root_path
		else
			if params[:products]
				@product = Products.find(params[:products]['id'])
				@product.update_attributes(params[:products])
				@product.save
			end
			@category = Categories.new
			@products = []
			@products = @products.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'index'
		end
	end

	def product_destroy
		unless isAdmin?
			redirect_to root_path
		else

			begin
				product = Products.find(params[:id])
			rescue ActiveRecord::RecordNotFound => e
				product = nil
			end

			if product
				product.destroy
				flash[:success] = "Item deleted!"
			end
			@category = Categories.new
			@products = []
			@products = @products.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'index'
		end
	end

	def categories
		unless isAdmin?
			redirect_to root_path
		else
			@category = Categories.all
			@category = @category.paginate page: params[:page], order: 'created_at desc', per_page: 12
		end
	end

	def category_edit
		unless isAdmin?
			redirect_to root_path
		else
			@category = Categories.find(params[:id])
		end
	end

	def category_save
		unless isAdmin?
			redirect_to root_path
		else
			if params[:categories]
				@category = Categories.find(params[:categories]['id'])
				@category.update_attributes(params[:categories])
				@category.save
			end
			@category = Categories.all
			@category = @category.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'categories'
		end
	end
	

	def category_destroy
		unless isAdmin?
			redirect_to root_path
		else
			begin
				category = Categories.find(params[:id])
			rescue ActiveRecord::RecordNotFound => e
				category = nil
			end
			if category
				category.destroy
				flash[:success] = "Item deleted!"
			end
			@category = Categories.all
			@category = @category.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'categories'
		end
	end

	def users
		unless isAdmin?
			redirect_to root_path
		else
			@users = User.where('role != ?','admin')
			@users = @users.paginate page: params[:page], order: 'created_at desc', per_page: 12
		end
	end

	def user_info
		unless isAdmin?
			redirect_to root_path
		else
			@user = User.find(params[:id])
		end
	end

	def user_destroy
		unless isAdmin?
			redirect_to root_path
		else
			begin
				user = User.find(params[:id])
			rescue ActiveRecord::RecordNotFound => e
				user = nil
			end
			if user
				user.destroy
				flash[:success] = "Item deleted!"
			end
			@users = User.where('role != ?','admin')
			@users = @users.paginate page: params[:page], order: 'created_at desc', per_page: 12
			render 'users'
		end
	end	

	def report
		unless isAdmin?
			redirect_to root_path
		else
		end
	end

	def report_month
		unless isAdmin?
			redirect_to root_path
		else
			@year = params['year'].to_i
			@month = params['month'].to_i
			order = Order.new
			@report_day = []
			if (@year!=0 && @month!=0)
				day = days(@month, @year)
				(1..day).each do |i|
					date = DateTime.new(@year, @month, i)
					@report_day[i-1] = order.find_by_date(date).count
				end
			end
		end
	end

	def report_day
		unless isAdmin?
			redirect_to root_path
		else
			@year = params['year'].to_i
			@month = params['month'].to_i
			@day   = params['day'].to_i
			if @day == nil
				@day = 0
			end
			order = Order.new
			@report_day = []
			day = days(@month, @year)
			(1..day).each do |i|
				date = DateTime.new(@year, @month, i)
				@report_day[i-1] = order.find_by_date(date).count
			end
			the_day = DateTime.new(@year, @month, @day)
			@day_order = order.find_by_date(the_day)
		end
	end

	def user_order
		unless isAdmin?
			redirect_to root_path
		else
			email = User.find(params[:id]).email
			@order = Order.where("email = ?", email)
			@order = @order.paginate page: params[:page], order: 'created_at desc', per_page: 10
		end
	end

end
