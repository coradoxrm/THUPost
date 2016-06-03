class UserEditController < ApplicationController
  before_action :authenticate_user!
  def edit
    @user = current_user
    @user.nickname = params[:nickname]
    @user.wechat = params[:wechat]
    @user.phone = params[:phone]
    @user.address = params[:address]
    # puts params
    # @user.update_attribute(@user.avatar, params[:user][:avatar])
    if params[:user]
      @user.avatar = params[:user][:avatar]
    end

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

  def show
    # puts current_user.avatar
    # puts "debug"
    @user = current_user
  end

end
