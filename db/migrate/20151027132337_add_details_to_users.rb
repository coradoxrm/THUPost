class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :phone, :string
    add_column :users, :wechat, :string
    add_column :users, :address, :text
  end
end
