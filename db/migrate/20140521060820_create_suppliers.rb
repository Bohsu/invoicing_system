class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name, :comment => "公司名称"
      t.integer :supplier_type_id, :comment => "公司类型"
      t.string :contact , :comment => "联系人"
      t.string :mobile, :comment => "手机"
      t.string :tel, :comment => "电话"
      t.string :fax, :comment => "传真"
      t.string :email, :comment => "邮箱"
      t.string :address, :comment => "地址"
      t.string :url, :comment => "公司网址"
      t.integer :status, :comment => "状态"
      t.text :remark, :comment => "备注"
      t.timestamps
    end

    add_index :suppliers, :name, :unique => true
  end
end
