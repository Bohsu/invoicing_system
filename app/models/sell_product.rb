# -*- encoding : utf-8 -*-

class SellProduct < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :sell_id

  def update_product(update_type, option)
    product = Product.find_by_id(self.product_id)
    quantity = nil
    case update_type
    when 'create'
      quantity = product.quantity.to_f - self.quantity
    when 'update'
      quantity = product.quantity.to_f + option.to_f - self.quantity
    when 'destroy'
      quantity = product.quantity.to_f + option.to_f
    end
    product.update_attribute(:quantity, quantity)
  end
end
