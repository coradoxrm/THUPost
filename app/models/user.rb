class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :products, :dependent => :delete_all
  has_many :orders, :dependent => :delete_all

  has_attached_file :avatar, styles: { small: "64x64", med: "100x100", large: "200x200" }, default_url: "/images/empty.jpg"
  # validates_attachment :avatar, presence: true,
  validates_attachment_content_type :avatar, content_type: [/\Aimage\/.*\Z/, nil, ""]
  # validates_attachment_size :avatar, in: 0..100000.kilobytes

  has_many :collections, :dependent => :delete_all
end
