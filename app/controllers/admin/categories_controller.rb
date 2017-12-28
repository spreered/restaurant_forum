class Admin::CategoriesController < Admin::BaseController
  before_action :set_category ,only: [:update,:destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
  end
  def create
    @category = Category.new(category_params)
    if @category.save 
      redirect_to admin_categories_path
    else
      render :index
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category is successfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    if@category.destroy
      flash[:alert] = "Category is successfully deleted"
    else
      flash[:alert] = @category.errors.messages[:base][0]
    end
    redirect_to admin_categories_path
  end



  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
  @category = Category.find(params[:id])
end
end
