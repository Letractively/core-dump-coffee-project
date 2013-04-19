class SearchController <ApplicationController

	def index
		@key = params[:keyword]
		@result = Products.search(@key,params[:page])
	end
	
end