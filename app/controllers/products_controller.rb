class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    resources
  end

  def new
    @product = Product.new
    3.times do
      @product.product_tags.build
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      (3 - product_tags_count).times do
        @product.product_tags.build
      end

      render 'new'
    end
  end

  def edit
    resources
    @product.product_tags.build
  end

  def update
    resources

    if @product.update(product_params)
      redirect_to @product
    else
      @product.product_tags.build

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

  def product_tags_count
    @product.product_tags.size
  end

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      product_tags_attributes: [:id, :name]
    )
  end
end
