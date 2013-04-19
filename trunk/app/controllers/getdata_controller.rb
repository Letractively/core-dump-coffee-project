require "open-uri"
require "json"

class GetdataController <ApplicationController
	def index
	end

	def create
		get_categories
	end

	def get_categories

		url = 'http://shopping.yahooapis.jp/ShoppingWebService/V1/json/categorySearch?appid=dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI-&category_id=1'

		buffer = URI.parse(url).read()

		result = JSON.parse(buffer)

		size =  result["ResultSet"]["0"]["Result"]["Categories"]["Children"].size
		for i in 0..20
			begin
			cate = Categories.new
			cate.name = result["ResultSet"]["0"]["Result"]["Categories"]["Children"][i.to_s]["Title"]["Medium"]
			cate.category_id = result["ResultSet"]["0"]["Result"]["Categories"]["Children"][i.to_s]["Id"]
			if !Categories.find_by_category_id(cate.category_id)
				cate.save
				get_products(cate.category_id)
			end
		    rescue
		    ensure
		    end
		end

		@echo =  "Completed get Categories and products items!"
		flash[:success] = @echo
		redirect_to getdata_path
	end

	def get_products(category)

		url = 'http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI-&category_id=%{cate}&sort=-sold&offset=1'%{:cate => category}

		buffer = URI.parse(url).read()

		result = JSON.parse(buffer)

		size = result["ResultSet"]["0"]['Result'].size
		for i in 0..20
			product = Products.new
			product.user_id = 0
			product.category_id = category
			product.product_id = result["ResultSet"]["0"]['Result'][i.to_s]['ProductId']
			product.name = result["ResultSet"]["0"]['Result'][i.to_s]['Name']
			product.imageurl = result["ResultSet"]["0"]['Result'][i.to_s]['Image']['Medium']
			product.price = result["ResultSet"]["0"]['Result'][i.to_s]['Price']['_value'].to_i
			product.currency = result["ResultSet"]["0"]['Result'][i.to_s]['Price']['_attributes']['currency']
			product.description = result["ResultSet"]["0"]['Result'][i.to_s]['Description']
			if !Products.find_by_product_id(product.product_id)
				product.save
			end
		end
	end

end

