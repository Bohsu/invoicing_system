class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.string :code, :comment => "单据编号"
      t.integer :customer_id, :comment => "客户ID"       
      t.string :category, :comment => "业务类别:销售;客户退货"
      t.decimal :total_price, :default => 0, :precision => 20, :scale => 4, :comment => "总金额"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :sells, :code, :unique => true
    add_index :sells, [:code, :customer_id], :unique => true
  end
end
