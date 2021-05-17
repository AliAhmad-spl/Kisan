class Cart < ApplicationRecord
  WHITELIST_PARAMS = %i[
    quantity
    subtotal
    total
    tax
    item_id
    order_id
    user_id
  ].freeze

  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true
  
  def add_item(item_id, quantity, price)
    line_item = line_items.where('item_id = ?', item_id).first
    item = Item.find(item_id)
    if line_item
      # increase the quantity of product in cart
      line_item.price = price
      line_item.quantity = line_item.quantity.to_i + quantity.to_i
      line_item.sub_total = subtotal(item, line_item.quantity)
      line_item.save
    else
      # product does not exist in cart

      line_items << LineItem.new(item_id: item_id, quantity: quantity, price: price, sub_total: subtotal(price, quantity))
    end
    save
  end

  def total_price
    line_items.to_a.sum(&:sub_total)
  end

  def subtotal(price, quantity)
    price.to_i * quantity.to_i
  end
end
