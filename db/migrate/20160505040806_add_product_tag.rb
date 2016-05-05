class AddProductTag < ActiveRecord::Migration
  def change
    add_column :products, :tag, :string
  end
end
