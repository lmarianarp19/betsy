class ProductsController < ApplicationController

  before_action only:[:edit] do
    @product = Product.find_by(id: params[:id])
    if @product
      restrict_merchant(@product.merchant.id)
    end
  end

  def index
    @category = Category.find_by(id: params[:id])

    if @category
      @order_item = OrderItem.new
      @products = @category.products
    else
      head :not_found
    end
  end

  def show
    @order = current_order
    @order_item = OrderItem.new
    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def new
    if @login_merchant
      @product = Product.new
    else
      flash_unathorized
      redirect_to root_path
    end
  end

  def create
    if @login_merchant
      # If category exists make a new product
      @product = Product.new(products_params) # This pulls in the params from the form and uses the categories and checks to see if the names are already in the database.
      @product.merchant_id = @login_merchant.id
      if save_and_flash(@product)
        redirect_to product_path(@product)
      else
        render :new, status: :bad_request
      end
    else
      flash_unathorized
      redirect_to root_path
    end
  end

  def edit
    if @login_merchant
      @product = Product.find_by(id: params[:id])
      unless @product
        head :not_found
      end
    else
      flash_unathorized
      redirect_to root_path
    end
  end

  def update
    if @login_merchant
      @product = Product.find(params[:id])

      if @product.update_attributes(products_params)
        flash[:status] = :success
        flash[:message] = "Successfully updated #{@product.name}!"
        redirect_to product_path(@product)
      else
        flash[:status] = :failure
        flash[:message] = "There was an error when updating your product"
        flash[:details] = @product.errors.messages
        render :edit, status: :bad_request
      end
    else
      flash_unathorized
      redirect_to root_path
    end
  end

  private

  def products_params
    params.require(:product).permit(:name, :price, :inventory,  :description, :photo_url, categories_attributes: [:name])
  end

end
