class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders, :dependent => :delete_all
  #{x: 4, y: 0}
  #{:x => 4, :y => 0}
end
