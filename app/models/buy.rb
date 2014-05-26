# -*- encoding : utf-8 -*-

class Buy < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :total_price

  has_many :buy_products, :dependent => :delete_all
  belongs_to :supplier

  def update_total_price
    self.total_price = self.buy_products.map(&:total_price).inject { |sum, n| sum + n } 
    self.save 
  end
  
end
