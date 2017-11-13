require 'csv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

def index
  @products = Product.all
  respond_to do |format|
    format.html
    format.csv do
      headers['Content-Disposition'] = "attachment; filename=\"product-list\""
      headers['Content-Type'] ||= 'text/csv'
    end
  end
end