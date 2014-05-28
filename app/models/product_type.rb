# -*- encoding : utf-8 -*-

class ProductType < ActiveRecord::Base

  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of  :name


  def self.get_product_types
    product_types = Hash.new
    ProductType.all.map{|type| product_types[type.name] = type.id }
    return product_types
  end
end
