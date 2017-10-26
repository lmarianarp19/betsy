class ProductsController < ApplicationController
  before_action only:[:edit] do
    @product = Product.find_by(id: params[:id])
    restrict_merchant(@product.merchant.id)
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

    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def new
    if @login_merchant
      @product = Product.new
    else
      # TODO: Make flash messages for unauthorized!!! When use is not logged in
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end

  def create
    if @login_merchant
      # If category exists make a new product
      @product = Product.new(products_params) # This pulls in the params from the form and uses the categories and checks to see if the names are already in the database.
      @product.merchant_id = @login_merchant.id
      save_and_flash(@product)
      redirect_to product_path(@product)
    else
      # TODO: Make flash messages for unauthorized!!! When use is not logged in
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end

  def edit
    if @login_merchant
      @product = Product.find_by(id: params[:id])

      unless @product
        head :not_found
      end
    #else

      #redirect_to merchant_products_path(@login_merchant.id)
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
        render :edit
      end
    end
  end


  # TODO: DELETE IF NOT USING THIS
  def destroy # RETIRE
    if @login_merchant
      @product = Product.find_by(id: params[:id])
      @product.current = false # Make status of the product false
      save_and_flash(@product)
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:result_text] = "You must be the product owner to delete this work!"
      redirect_to root_path
    end
  end

  private

  def products_params
    params.require(:product).permit(:name, :price, :inventory,  :description, :photo_url, categories_attributes: [:name])
  end

end
