class AlterCategoryToSells < ActiveRecord::Migration
  def change
  	rename_column :sells, :type, :category
  end
end
