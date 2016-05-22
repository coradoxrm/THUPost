class Collection < ActiveRecord::Migration
  def change
    create_table :Collections do |t|
        t.belongs_to :user
        t.belongs_to :product
    end
  end
end
