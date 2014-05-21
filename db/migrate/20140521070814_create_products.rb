class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code, :comment => "商品编号"
      t.string :name, :comment => "商品名称"
      t.integer :product_type_id, :comment => "商品类别_ID"       
      t.string :model , :comment => "型号"
      t.integer :quantity, :comment => "当前数量"    
      t.string :unit, :comment => "计量单位" 
      t.decimal :buy_price, :default => 0, :precision => 20, :scale => 4, :comment => "采购价格"
      t.decimal :sell_price, :default => 0, :precision => 20, :scale => 4, :comment => "销售价格"
      t.decimal :buy_total_price, :default => 0, :precision => 20, :scale => 4, :comment => "采购总价"
      t.decimal :sell_total_price, :default => 0, :precision => 20, :scale => 4, :comment => "销售总价"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :products, :code, :unique => true
    add_index :products, [:name, :model], :unique => true
  end
end
     
     
     
     