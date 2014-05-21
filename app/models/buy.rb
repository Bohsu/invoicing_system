# -*- encoding : utf-8 -*-

class Buy < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected :total_price

  belongs_to :supplier
  
end
