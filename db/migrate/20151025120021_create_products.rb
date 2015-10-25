class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :price
      t.belongs_to :user, index: true
      t.integer :status, default: 0
      # TODO tags
      t.timestamps null: false
    end
  end
end
