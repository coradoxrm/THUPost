class AddProductImage < ActiveRecord::Migration
  def change
    add_attachment :products, :photo0
    add_attachment :products, :photo1
    add_attachment :products, :photo2
    add_attachment :products, :photo3
    add_attachment :products, :photo4
  end
end
