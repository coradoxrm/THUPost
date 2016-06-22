class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders, :dependent => :delete_all
  has_many :collections, :dependent => :delete_all
  #{x: 4, y: 0}
  #{:x => 4, :y => 0}

  #has_attached_file :photo0, styles: { small: "64x64", med: "100x100", large: "200x200", thumb: "400x400#" },
  has_attached_file :photo0, styles: { thumb: "400x400#" },
    default_url: "/images/empty.jpg"

  validates_attachment_content_type :photo0, content_type: [/\Aimage\/.*\Z/, nil, ""]

  #has_attached_file :photo1, styles: { small: "64x64", med: "100x100", large: "200x200", thumb: "400x400#" },
  has_attached_file :photo1, styles: { thumb: "400x400#" },
    default_url: "/images/empty.jpg"

  validates_attachment_content_type :photo1, content_type: [/\Aimage\/.*\Z/, nil, ""]

  #has_attached_file :photo2, styles: { small: "64x64", med: "100x100", large: "200x200", thumb: "400x400#" },
  has_attached_file :photo2, styles: { thumb: "400x400#" },
    default_url: "/images/empty.jpg"

  validates_attachment_content_type :photo2, content_type: [/\Aimage\/.*\Z/, nil, ""]

  #has_attached_file :photo3, styles: { small: "64x64", med: "100x100", large: "200x200", thumb: "400x400#" },
  has_attached_file :photo3, styles: { thumb: "400x400#" },
    default_url: "/images/empty.jpg"
  validates_attachment_content_type :photo3, content_type: [/\Aimage\/.*\Z/, nil, ""]

  #has_attached_file :photo4, styles: { small: "64x64", med: "100x100", large: "200x200", thumb: "400x400#" },
  has_attached_file :photo4, styles: { thumb: "400x400#" },
    default_url: "/images/empty.jpg"
  validates_attachment_content_type :photo4, content_type: [/\Aimage\/.*\Z/, nil, ""]


end
