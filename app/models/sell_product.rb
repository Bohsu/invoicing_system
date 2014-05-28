# -*- encoding : utf-8 -*-

class SellProduct < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :sell_id

  validates_presence_of :quantity
  validates_uniqueness_of :product_id, :scope => :sell_id, :message => "本次销售已添加该商品!"
  validates_numericality_of :quantity, :only_integer => true

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
