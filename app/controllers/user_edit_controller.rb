class UserEditController < ApplicationController
  def edit
    @user = current_user
    @user.nickname = params[:nickname]
    @user.wechat = params[:wechat]
    @user.phone = params[:phone]
    @user.address = params[:address]

    @user.save
    flash[:notice] = "successfully edited"
    redirect_to user_edit_show_path
  end

  def show
    @user = current_user
  end

end
