class ShopController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    if params[:set_locale]
      @products = Product.paginate(page: params[:page], per_page: 10)
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title).paginate(page: params[:page], per_page: 10)
      #@products = Product.order(:title)
      # paginate page only
      #@products = Product.paginate(page: params[:page], per_page: 10)
    end
  end
end