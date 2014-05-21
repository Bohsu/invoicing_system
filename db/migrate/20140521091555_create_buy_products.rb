class CreateBuyProducts < ActiveRecord::Migration
  def change
    create_table :buy_products do |t|
      t.integer :buy_id, :comment => "进货单_ID"  
      t.integer :product_id, :comment => "商品_ID"  
      t.string :model, :comment => "型号"      
      t.integer :quantity, :comment => "数量"  
      t.string :unit, :comment => "计量单位"   
      t.decimal :price, :default => 0, :precision => 20, :scale => 4, :comment => "采购价格"
      t.decimal :total_price, :default => 0, :precision => 20, :scale => 4, :comment => "采购总价"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :buy_products, [:buy_id, :product_id], :unique => true
  end
end
