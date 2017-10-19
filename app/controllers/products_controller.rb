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
    # input_name = params[:product][:name].upcase
    # input_category = params[:product][:category_id]
    #
    # existing_product = Product.find_by(name: input_name)
    #
    # if existing_product
    #   # Look for all the categories that exist for this product!
    #   all_categories_for_product = existing_product.product_categories # An array of all product_category instances
    #
    #   all_categories_for_product.category.name.include? input_category
    #   # do not make a new category for this product
    #   @product = Product.new(products_params)
    #
    #   @product.merchant_id = session[:merchant_id]
    #   @product.category_id =
    #
    # else
    #   @product = Product.new(products_params)
    #
    #   @product.
    #




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
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url, :category_id)
  end

end


  # Create a new product providing:
  # name
  # description
  # price
  # photo URL
  # stock
