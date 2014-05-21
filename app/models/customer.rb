# -*- encoding : utf-8 -*-

class Customer < ActiveRecord::Base

  attr_protected :status

  validates_presence_of :name
end
