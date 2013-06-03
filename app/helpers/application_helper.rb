module ApplicationHelper	
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Welcome to Coffe 2 Go"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def days(month, year)
   if (month == 2 && Date.gregorian_leap?(year))
    return 29 
  else
   COMMON_YEAR_DAYS_IN_MONTH[month]
  end
 end

 def get_order_detail(id)
   order_detail = OrderDetail.where(:order_id => id)
 end

 def get_product_name(id)
   order_detail = Products.find(id).name
 end

 def get_locale
     return session[:locale] ? session[:locale].to_sym : I18n.default_locale
  end
 
 def set_locale (locale)
        locales = [:vn, :en]
        if locales.include? locale.to_sym
            I18n.locale = locale
            session[:locale] = locale
        end
 end

end
