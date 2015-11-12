class Admin::ProductsController < AdminController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      save_picture
      redirect_to [:admin, @product]
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      save_picture
      redirect_to [:admin, @product]
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.destroy(params[:id])
    redirect_to admin_products_url
  end
  
  def destroyMulti
    Product.where(:id => params[:ids]).destroy_all
    respond_to do |format|
      format.html {redirect_to admin_products_path}
      format.js{}
      format.json{head :no_content}
    end
    
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end

  def save_picture
    uploaded_file = params[:product][:picture]

    unless uploaded_file.nil?
      new_file_path = Rails.root.join('public', 'uploads', @product.id.to_s)

      File.open(new_file_path, 'wb') do |file|
        file.write uploaded_file.read
      end
    end
  end
end
