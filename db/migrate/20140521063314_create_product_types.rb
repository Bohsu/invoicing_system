class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name, :comment => "商品类别"
      t.timestamps
    end

    add_index :product_types, :name, :unique => true
  end
end
