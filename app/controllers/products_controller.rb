class ProductsController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  
  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
  end

  
  def show
    @product = Product.find(params[:id])
    respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render action: 'show',
          status: :created, location: @product }
    end
  end
  
  # products/showoncategory/:id
  def showoncategory
    @products = Product.where("category_id = ?", params[:id]).paginate(page: params[:page], per_page: 10)
    
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
end
