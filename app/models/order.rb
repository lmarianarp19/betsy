class Order < ApplicationRecord
  CATEGORIES = %w(paid complete)
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  #TODO test calculate total

  def calculate_total
    self.order_items.collect { |item| item.product.price * item.quantity}.sum
  end

  def ship_order
    all_items = self.order_items
    all_items.each do |order_item|
      if order_item.shipped == false
        return false
      end
    end
    return true
  end

  def change_to_shipped
    if self.ship_order
      return self.status = "complete"
    end

  end

  def order_item_attributes=(order_item_attributes)
    if @order.product_ids.include? order_item_attributes[:product_id]
      order_item = @order.product_ids.where(:product_id)
      order_item.quantity = :quantity
    else
      order_item = OrderItem.new(order_items_attributes)
      self.order_items << order_item
    end
  end

    # product = Product.find(order_item_attributes.product_id)
    #   if self.order_items.include? product
    #
    #     # update quantity
    #   else
    #     self.order_items << product






end
