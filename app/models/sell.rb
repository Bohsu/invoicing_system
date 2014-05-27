# -*- encoding : utf-8 -*-

class Sell < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :total_price

  has_many :sell_products, :dependent => :delete_all
  belongs_to :customer

  def update_total_price
    self.total_price = self.sell_products.map(&:total_price).inject { |sum, n| sum + n } 
    self.save 
  end
end
