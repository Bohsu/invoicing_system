# -*- encoding : utf-8 -*-

class BuyProduct < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_protected: buy_id
end
