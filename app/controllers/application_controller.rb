class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  layout :layout_by_resource

  #before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :nickname, :phone, :wechat, :address,:current_password,:avatar) }
  end

  def layout_by_resource
    if devise_controller?
      #print("-------------------> one\n")
      #print(action_name + "\n")
      #print(controller_name + "\n")

      (action_name == 'edit' && controller_name != 'passwords') ? 'application' : 'empty'

    else
      print("-------------------> two")
      'application'
    end
  end
end
