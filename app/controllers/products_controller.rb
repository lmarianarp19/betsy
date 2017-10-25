class ProductsController < ApplicationController

  # skip_before_action :find_merchant, only: [:index, :show]

  ###### TODO: NOT WORKING. IF CATEGORY IS NIL. PRODUCTS TEST ARE NOT PASSING SEE APPLICATION.HTML.ERB%>

  def index
    @category = Category.find_by(id: params[:id])
    if @category
      @order_item = OrderItem.new
      # @order_item = current_order.order_items.new
      @products = @category.products
    else
      head :not_found
    end
  end

  def show
    @order_item = current_order.order_items.new

    @product = Product.find_by(id: params[:id])
    unless @product
      head :not_found
    end
  end

  def new
    if @login_merchant
      @product = Product.new
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end

  def create
    if @login_merchant
      # binding.pry
      #input_cat_name = params[:product][:category_ids]

      #@category = Category.find(input_cat_name)

      #if @category # If category exists make a new product
      @product = Product.new(products_params) # This pulls in the params from the form and uses the categories and checks to see if the names are already in the database.
      #@product.categories << @category
      # @product.category_id = category.id
      @product.merchant_id = @login_merchant.id
      save_and_flash(@product)

      redirect_to product_path(@product)
      # else
      #   # If category does not exist and is valid
      #   @category = Category.create_cat(input_cat_name)
      #   @product = Product.new(products_params)
      #   @product.merchant_id = @login_merchant.id
      #   @product.categories << @category
      #   save_and_flash(@product)
      #
      #   redirect_to product_path(@product)
      #  end

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

      # TODO: Render a 404 error when not found ruby specific 404 page?
      unless @product
        head :not_found
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end

  def update
    # TODO: how to not use Product.find and get test to pass?
    if @login_merchant
      @product = Product.find(params[:id])
      if @product.update_attributes(products_params) # This pulls in the params from the form and uses the categories and checks to see if the names are already in the database.
        flash[:status] = :success
        flash[:message] = "Successfully updated #{@product.name}!"
        #@product.categories << @category
        # @product.category_id = category.id
        # @product.merchant_id = @login_merchant.id
        redirect_to product_path(@product)
        # input_cat_name = params[:product][:categories]
        # @category = Category.find_by(name: input_cat_name)
        # @product = Product.find_by(id: params[:id])
        #
        # if @category && @product # If category exists update prodouct
        #   @product.update_attributes(products_params)
        #   if save_and_flash(@product)
        #     redirect_to product_path(@product)
        #   else
        #     redirect_to root_path
        #   end
        # else
        # If category does not exist and is valid make a new category and update product
        # @category = Category.create_cat(input_cat_name)
        # @product.categories << @category
        # save_and_flash(@product)
        #
        # redirect_to product_path(@product)
        # end
      else
        flash[:status] = :failure
        flash[:message] = "There was an error when updating your product"
        flash[:details] = @product.errors.messages
        render :edit
      end
    end
  end

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
