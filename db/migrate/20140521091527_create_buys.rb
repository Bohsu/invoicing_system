class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.string :code, :comment => "单据编号"
      t.integer :supplier_id, :comment => "供应商ID"       
      t.string :type, :comment => "业务类别:进货、退货"
      t.decimal :total_price, :default => 0, :precision => 20, :scale => 4, :comment => "总金额"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :buys, :code, :unique => true
    add_index :buys, [:code, :supplier_id], :unique => true
  end
end
