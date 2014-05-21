class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name, :comment => "计量单位名称"
      t.integer :sort, :comment => "排序"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :units, :name, :unique => true
  end
end
