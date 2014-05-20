# -*- encoding : utf-8 -*-

class Customer < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :status
end
