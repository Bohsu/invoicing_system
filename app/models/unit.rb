# -*- encoding : utf-8 -*-

class Unit < ActiveRecord::Base
	
  attr_accessible :name, :remark

  validates_presence_of :name
  validates_uniqueness_of  :name

  def self.get_units
    Unit.all.map {|unit| unit.name }
  end

end
