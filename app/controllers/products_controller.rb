class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    resources
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    resources
  end

  def update
    resources

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    resources
    @product.destroy

    redirect_to products_path
  end

  private

  def resources
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
