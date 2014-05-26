class AddProductNameToBuyProduct < ActiveRecord::Migration
  def change
  	 add_column :buy_products, :name, :string, :comment => "商品名称,防止变更"
  end
end
