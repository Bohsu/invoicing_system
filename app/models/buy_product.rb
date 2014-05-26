# -*- encoding : utf-8 -*-

class BuyProduct < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :buy_id

  def update_product
    product = Product.find_by_id(self.product_id)
    product.update_attribute(:quantity, self.quantity)
  end
end
