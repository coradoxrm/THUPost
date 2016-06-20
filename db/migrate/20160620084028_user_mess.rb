class UserMess < ActiveRecord::Migration
  def change
    add_column :users, :last_text_time, :integer, :default => 0
  end
end
