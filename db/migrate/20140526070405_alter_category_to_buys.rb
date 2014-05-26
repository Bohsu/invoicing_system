class AlterCategoryToBuys < ActiveRecord::Migration
  def change
  	rename_column :buys, :type, :category
  end
end
