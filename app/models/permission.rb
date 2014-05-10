# -*- encoding : utf-8 -*-

class Permission < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :url, :parent_id, :is_menu, :hide, :blank

  
  has_many :permission_users, :dependent => :delete_all
  has_many :users, :through => :permission_users

  validates :name, presence: true

  has_ancestry

  scope :menus, where(:is_menu => true)
end
