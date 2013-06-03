class SearchController <ApplicationController

	
	
	def index
		@search = Products.search do 
			fulltext params[':keyword'] 
		end
		@result = @search.results 
		@key = params[':keyword'] 
	end


end