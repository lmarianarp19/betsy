class OrderItemsController < ApplicationController

  def create
    if @current_order.nil?
      order = Order.create_new_order # Create a new order
      session[:order_id] = order.id
      @order_item = OrderItem.new(order_items_params)
      @order_item.order_id = order.id
      save_and_flash(@order_item)
      order.order_items << @order_item
      save_and_flash(order)
      flash[:status] = :success
      flash[:message] = "Added #{@order_item.product.name} to the cart!"
      redirect_to order_path(order)
    elsif @current_order
      @order_item = OrderItem.new(order_items_params)
      @order_item.order_id = @current_order
      save_and_flash(@order_item)
      @current_order.order_items << @order_item
      save_and_flash(@current_order)
      flash[:status] = :success
      flash[:message] = "Added #{@order_item.product.name} to the cart!"
      redirect_to order_path(order)
    else
      flash[:status] = :failure
      flash[:message] = "Could not add item to cart!"
    end
  end





  # if @current_order.nil? #TODO: Merchant needs to be able to buy things
  #   order = Order.create_new_order # Create a new order
  #   session[:order_id] = order.id
  #
  #   # TODO: HOW THE EFF DO WE PASS IN THE PRODUCT ID??
  #   @order_item = OrderItem.new(quantity: 1, order_id: session[:order_id], product_id: params[:product][:id])
  #
  #   save_and_flash(@order_item)
  #   order.order_items << @order_item
  # elsif @current_order # If there is already an order going
  #
  #   @order_item = OrderItem.new(quantity: 1, order_id: session[:order_id], product_id: params[:product][:id])
  #
  #   save_and_flash(@order_item)
  #   @current_order.order_items << @order_item
  #   save_and_flash(@current_order)
  # else
  #   flash[:status] = :failure
  #   flash[:message] = "Could not add item to cart!"
  # end
  # redirect_to product_path(params[:product][:id])


  def update
    # @order = @current_order_id
    # @order_item = @order.order_items.find(params[:id])
    # @order_id.update_attributes(order_items_params)

    #TODO: Raise some kind of error here if it didnt save
  end

  def destroy
    @order_item = @current_order_id.order_items.find(params[:id])

    if @order_item.destroy
      flash[:success] = :success
      flash[:message] = "Your cart has been updated!"
      redirect_to order_parth(@current_order_id) # Product View Pag
    else
      # Raise some other kind of error
    end

  end

  private

  def order_items_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
