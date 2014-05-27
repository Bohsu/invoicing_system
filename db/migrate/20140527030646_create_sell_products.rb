class CreateSellProducts < ActiveRecord::Migration
  def change
    create_table :sell_products do |t|
      t.integer :sell_id, :comment => "销售单ID"  
      t.integer :product_id, :comment => "商品_ID"  
      t.string :name, :string, :comment => "商品名称,防止变更"
      t.string :model, :comment => "型号"      
      t.integer :quantity, :comment => "数量"  
      t.string :unit, :comment => "计量单位"   
      t.decimal :price, :default => 0, :precision => 20, :scale => 4, :comment => "销售价格"
      t.decimal :total_price, :default => 0, :precision => 20, :scale => 4, :comment => "销售总价"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

     add_index :sell_products, [:sell_id, :product_id], :unique => true
  end
end
