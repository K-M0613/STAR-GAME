class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_root_path
    elsif resource == :user
      root_path
    end
  end
  
  add_flash_types :success, :info, :warning, :danger

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :birth_day, :gender])
    end
end
