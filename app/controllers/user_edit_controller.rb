class UserEditController < ApplicationController
  before_action :authenticate_user!
  def edit
    @user = current_user
    @user.nickname = params[:nickname]
    @user.wechat = params[:wechat]
    @user.phone = params[:phone]
    @user.address = params[:address]
    if params[:user]
      @user.avatar = params[:user][:avatar]
    x1 = params[:x1].to_i
    y1 = params[:y1].to_i
    x2 = params[:x2].to_i
    y2 = params[:y2].to_i
    @user.set_crop(x2-x1,y2-y1,x1,y1)
        logger.info 'informational message'
        logger.info x1
        logger.info y1
        logger.info x2-x1
        logger.info y2-y1
        logger.info @user
        logger.info 'info done'
    end
    # puts params
    # @user.update_attribute(@user.avatar, params[:user][:avatar])

    # puts "fsdfds"
    # puts @user.avatar
    # @user.avatar = nil
    # remove_avatar = 1

    @user.save
    # puts "nimas"
    # puts @user.avatar_file_name
    # puts @user.avatar
    # puts "nimas2"
    flash[:notice] = "successfully edited"
    redirect_to user_edit_show_path
  end

  def avatar_upload
    x1 = params[:x1]
    y1 = params[:y1]
    x2 = params[:x2]
    y2 = params[:y2]
    avatar = params[:user][:avatar]
    #cut image by using imagemagick

    #todo

    #save avatar
    @user.avatar = avatar
    @user.save
  end

  def show
    # puts current_user.avatar
    # puts "debug"
    @user = current_user
  end

end
