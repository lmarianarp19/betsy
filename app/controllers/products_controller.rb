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
    input_name = params[:product][:name]

    existing_product = Product.find_by(name: input_name)

    if existing_product # If category for this DOES exist for this name
      all_product_categories = existing_product.product_categories

      all_product_categories.each do |pc|
        if pc.product.name == input_name
          @product = Product.new(products_params)
          @product.merchant_id = session[:merchant_id]

          if @product.save!
            redirect_to product_path(@product.id)
          else
            flash[:status] = :failure
            flash[:message] = "There was a problem when saving your product!"
            flash[:errors] = @product.errors.messages
            render :new, status: :bad_request
          end
        end
      end

    else # If category for this name DOES NOT exist
      Category.create_cat(input_name)

      @product = Product.new(products_params)
      @product.merchant_id = session[:merchant_uid]

      # Create a new productcategory if it does not exist
      if @product.save
        ProductCategory.create_prod_cat(@product)
      else
        flash[:status] = :failure
        flash[:message] = "There was a problem when saving your product!"
        flash[:errors] = @product.errors.messages
        redirect_to new_product_path
      end
    end

  end






    # Category.find_or_create_cat(params[:product][:category_id])
    #
    # @product = Product.new(products_params)
    #
    # @product.category_id = category_id
    #
    # if @product.save
    #   flash[:status] = :success
    #   flash[:message] = "You created a new product: #{@product.name}"
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "Your product was not created. Please try again!"
    #   flash[:errors] = @product.errors.messages
    # end

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
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url, :category_id)
  end

end


  # Create a new product providing:
  # name
  # description
  # price
  # photo URL
  # stock
