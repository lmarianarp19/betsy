class ProductsController < ApplicationController

  skip_before_action :find_merchant, only: [:index, :show]

  def index
    # TODO: Should this be separated out ito its own method?
    @category = Category.find_by(id: params[:id])
    if @category
      @products = @category.products
    else
      head :not_found
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      # TODO: render a 404 page if not found
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
      input_cat_name = params[:product][:categories]

      @category = Category.find_by(name: input_cat_name)

      if @category # If category exists make a new product
        @product = Product.new(products_params)
        @product.categories << @category
        # @product.category_id = category.id
        @product.merchant_id = @login_merchant.id
        save_and_flash(@product)

        redirect_to root_path
      else
        # If category does not exist and is valid
        @category = Category.create_cat(input_cat_name)
        # if save_and_flash(@category)
        @product = Product.new(products_params)
        @product.merchant_id = @login_merchant.id
        @product.categories << @category
        save_and_flash(@product)

        redirect_to product_path(@product)
        # else
        #   render :new, status: :bad_request
        # end
      end
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
      input_cat_name = params[:product][:categories]
      @category = Category.find_by(name: input_cat_name)
      @product = Product.find_by(id: params[:id])

      if @category && @product # If category exists update prodouct
        @product.update_attributes(products_params)
        if save_and_flash(@product)
          redirect_to product_path(@product)
        else
          redirect_to root_path
        end
      else
        # If category does not exist and is valid make a new category and update product
        @category = Category.create_cat(input_cat_name)
        @product.categories << @category
        save_and_flash(@product)

        redirect_to product_path(@product)
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be authorized to do that"
      redirect_to root_path
    end
  end


    #   if save and flash(@product)
    #     redirect_to product_path(@product)
    #   else
    #     redirect_to root_path
    #   end
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "You must be authorized to do that"
    #   redirect_to root_path
    # end


  def destroy # RETIRE
    if @login_merchant
      binding.pry
      @product = Product.find_by(id: params[:id])
      @product.current = false # Make status of the product false
      save_and_flash(@product)
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
    params.require(:product).permit(:name, :price, :inventory,  :description, :photo_url)
  end

end
