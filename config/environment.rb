# Load the Rails application.
require File.expand_path('../application', __FILE__)
Paperclip.options[:image_magick_path] = "/usr/local/Cellar/imagemagick/6.9.3-7/bin/"
Paperclip.options[:command_path] = "/usr/local/Cellar/imagemagick/6.9.3-7/bin/"
# Initialize the Rails application.
Rails.application.initialize!
config.time_zone = 'Beijing'
config.active_record.default_timezone = :local
