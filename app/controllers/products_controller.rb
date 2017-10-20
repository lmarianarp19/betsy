class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def new
    @product = Product.new
  end

  def create

    category = Category.find_by(name: params[:product][:categories])

    if category # If category exists
      @product = Product.new(products_params)
      # For all existing product categories, add a new category for this product
      @product.categories << category

      # @product.category_id = category.id
      @product.merchant_id = session[:merchant_id]
      save_and_flash(@product)
      redirect_to root_path
    else # If category does not exist and is valid
      category = Category.create_cat(params[:product][:categories])
      @product = Product.new(products_params)
      @product.merchant_id = session[:merchant_id]
      @product.categories << category
      save_and_flash(@product)
      redirect_to product_path(@product)
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])

    unless @product
      head :not_found
    end
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

  def products_params
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url)
  end

end
