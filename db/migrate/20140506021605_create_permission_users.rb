class CreatePermissionUsers < ActiveRecord::Migration
  def change
    create_table :permission_users, :id => false do |t|
      t.integer :user_id      , :comment => "用户id"
      t.integer :permission_id, :comment => "权限id"
      t.timestamps
    end
    
    add_index :permission_users, :user_id
    add_index :permission_users, :permission_id
    add_index :permission_users, [:user_id, :permission_id], :unique => true
  end
end
