# -*- encoding : utf-8 -*-

class Supplier < ActiveRecord::Base
	
  attr_protected :status

  validates_presence_of :name, :contact, :tel 
  validates_uniqueness_of  :name, :case_sensitive => false, :message => "该供应商已存在!"
end
