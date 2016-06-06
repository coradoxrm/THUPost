class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :nickname,:password,:phone, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :nickname, :phone, :wechat, :address, :current_password, :avatar)
  end

  def after_inactive_sign_up_path_for(resource)
    '/other/check' # Or :prefix_to_your_route
  end

end
