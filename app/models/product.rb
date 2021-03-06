# -*- encoding : utf-8 -*-

class Product < ActiveRecord::Base

  attr_accessible :code, :name, :product_type_id, :model, :quantity, :unit, :buy_price, :sell_price, :buy_total_price, :sell_total_price, :remark
  
  belongs_to :product_type

  validates_presence_of :name, :model
  validates_uniqueness_of :name, :scope => :model
  validates_numericality_of :quantity, :only_integer => true
end
