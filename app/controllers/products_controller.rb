class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(products_params)

    if @product.save!
      flash[:status] = :success
      flash[:message] = "You created a new product: #{@product.name}"
    else
      flash[:status] = :failure
      flash[:message] = "Your product was not created. Please try again!"
      flash[:errors] = @product.errors.messages
    end
  end

  def edit
  end

  def update
    @product.update_attributes(products_params)

    if @product.save!
      flash[:status] = :success
      flash[:message] = "You updated product: #{@product.name}"
    else
      flash[:status] = :failure
      flash[:message] = "You product could not be updated. Please try again!"
      flash[:errors] = @product.errors.messages
    end
  end

  def destroy # RETIRE
    if @merchant_id
      @product.current_status = false # Make status of the product false
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:result_text] = "You must be the product owner to delete this work!"
      flash[:messages] = @product.errors.messages
      redirect_to product_path(@product)
    end
  end

  private

  params.require(:product).permit(:name, :price, :description, :photo_url, :num_in_stock, :current_status, :merchant_id, :category_id,)
end


  # Create a new product providing:
  # name
  # description
  # price
  # photo URL
  # stock
