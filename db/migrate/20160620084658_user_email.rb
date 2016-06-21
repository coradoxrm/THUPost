class UserEmail < ActiveRecord::Migration
  def change
    add_column :users, :last_email_time, :integer, :default => 0
  end
end

