class StoreController < ApplicationController
  def index
  	@products = Product.all
  	@cart = current_cart
  	@num_views = increment_views
  	@views_html = "(You've been here #{@num_views} times)" if @num_views > 5
  end
end
