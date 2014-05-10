# -*- encoding : utf-8 -*-

class PermissionUser < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :permission
  belongs_to :user
  
  attr_accessible :permission_id, :user_id
end
