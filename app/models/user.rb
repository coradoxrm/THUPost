class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  @@crop_set = "-crop 200x200+0+0 -resize 150x150^"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :products, :dependent => :delete_all
  has_many :orders, :dependent => :delete_all

  has_attached_file :avatar, :styles => {:small => ""}, :convert_options => {:small => "#{@@crop_set}" }, 
                    :default_url => "/images/empty.jpg", :default_style => :small
  # validates_attachment :avatar, presence: true,
  validates_attachment_content_type :avatar, content_type: [/\Aimage\/.*\Z/, nil, ""]
  # validates_attachment_size :avatar, in: 0..100000.kilobytes

  has_many :collections, :dependent => :delete_all

  def set_crop(crop_w,crop_h,crop_x,crop_y)
    @crop_w = crop_w
    @crop_h = crop_h
    @crop_x = crop_x
    @crop_y = crop_y
    logger.info "haha"
    logger.info @@crop_set
    @@crop_set = "-crop #{@crop_w}x#{@crop_h}+#{@crop_x}+#{@crop_y} -resize 100x100^"
    logger.info "heihei"
    logger.info @@crop_set
  end
end
