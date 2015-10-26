class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.text :description
      t.float :price
      t.boolean :is_chosen, default: false
      t.timestamps null: false
    end
  end
end
