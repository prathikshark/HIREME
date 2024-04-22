class ApplicationController < ActionController::Base
  before_action :configure_sanitized_params, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    puts "IsAdmin: #{resource.isadmin?}"
    if resource.is_a?(User) && resource.isadmin?
      admins_path
    else
      root_path
    end
  end

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit(:name, :phone, :address,:email, :password, :password_confirmation, worker_attributes: [:SSnumber, :age, :gender, :profile_picture, :from_date, :to_date])
     end
  end
end




  
