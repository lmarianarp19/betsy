class OrderItemsController < ApplicationController

  def new
    @order_item = OrderItem.new
  end

  def create
    @order = current_order
    @item = @order.order_items.new(order_items_params)
    @order.save
    flash[:status] = :success
    flash[:message] = "Item was added to your cart"
    session[:order_id] = @order.id
    redirect_to cart_path

    
      # redirect_to product_category_path(:id[params(:id)],:product_id[params(:product_id)])
    # else
    #   flash[:status] = :failure
    #   flash[:message] = "Unable to change quantity"
    #   redirect_to root_path
      # redirect_to product_category_path
    # end
  end
  # @order_item = OrderItem.new(order_items_params)
  # @order_item.order #insert session[:order_id]
  # #TODO: Raise some kind of error here if it didnt save
  # end

  def update
    @order_item = OrderItem.find_by(id: params[:id])
    @order_item.update_attributes(order_items_params)
    if @order_item.save
      redirect_to cart_path
    else
      flash[:status] = :failure
      flash[:message] = "Unable to change quantity"
    end

    # @order = @current_order_id
    # @order_item = @order.order_items.find(params[:id])
    # @order_id.update_attributes(order_items_params)

    #TODO: Raise some kind of error here if it didnt save
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.destroy
    @order.save

    redirect_to cart_path

    # @order_item = @current_order_id.order_items.find(params[:id])
    #
    # if @order_item.destroy
    #   flash[:success] = :success
    #   flash[:message] = "Your cart has been updated!"
    #   redirect_to order_parth(@current_order_id) # Product View Pag
    # else
    #   # Raise some other kind of error
    # end

  end

  def ship
    @order_item = OrderItem.find_by(id: params[:id])
    @order_item.update_attributes(order_items_params)

  end

  private

  def order_items_params
    params.require(:order_item).permit(:product_id, :quantity)
  end


end
