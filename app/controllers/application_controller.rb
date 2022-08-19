class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]


  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_root_path
    elsif resource == :user
      root_path
    end
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:nickname, :birth_day, :gender])
    end
end
