class ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    #print(edit_user_registration_path)
    #edit_user_registration_path
    #user_edit_edit_path
    home_path
  end

end
