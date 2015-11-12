class Admin::CategoriesController < AdminController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def destroy
    Category.destroy(params[:id])

    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
