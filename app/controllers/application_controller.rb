require 'will_paginate/array'
class ApplicationController < ActionController::Base
protect_from_forgery
before_filter :init_locale
include SessionsHelper
include CategoriesHelper
include ApplicationHelper


  def switch_locale
    set_locale(params[:locale]) unless params[:locale].nil?
    redirect_to request.referer
  end

  def init_locale
    I18n.locale = get_locale
  end

end
