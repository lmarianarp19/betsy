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

# product_name = params[:product][:name]
#
# product = Product.find_by(name: product_name)
#
# if product # if the product exists, look for all the categories associated with it
#   product_categories = product.product_categories # This needs to be an array
#   product_categories.each do |prod_cat|
#     if prod_cat.category.name == product_name
#       Product.new
# # category_id =

#product_categories.category.name

# TODO: I SKIPPED THE INTERMEDIATE PRODUCTS CATEGORIES TABLE

# 1. Category name is inputted into the create form
# 2. Look for the product name in all products
# 3. Get all product_categories associated with the product
# 4. If category.name is equal to category name that was inputted from the user, do not allow it be created_at
# 5. Else, create a new product in the category



  def create
    input_name = params[:product][:name].upcase

    existing_product = Product.find_by(name: input_name)

    if existing_product # If category for this DOES exist for this name
      all_product_categories = existing_product.product_categories

      all_product_categories.each do |pc|
        if pc.category_id.name == input_name
          @product = Product.new(products_params)
          @product.merchant_id = session[:merchant_id]
          @product.category_id = pc.category_id
          redirect_to product_path(@product.id)
        end
      end

    else # If category for this name DOES NOT exist
      new_category = Category.create_cat(input_name)

      @product = Product.new(products_params)
      @product.merchant_id = session[:merchant_id]
      @product.category_id = new_category.id

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
