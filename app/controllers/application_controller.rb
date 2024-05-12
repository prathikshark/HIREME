class ApplicationController < ActionController::Base
  before_action :configure_sanitized_params, if: :devise_controller? 
  after_action :set_role_from_hidden_param, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.is_a?(User) && current_user.role == "admin"
      admins_path
    else
      root_path
    end
  end

  private

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :address, :email, :password, :password_confirmation, worker_attributes: [:SSnumber, :age, :gender, :profile_picture, :from_date, :to_date, :shift, :educational_qualification, :marital_status, :language, :date_of_birth]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :address, :email, :password, :password_confirmation, :current_password, worker_attributes: [:SSnumber, :age, :gender, :profile_picture, :from_date, :to_date, :shift, :educational_qualification, :marital_status, :language, :date_of_birth]])
  end

  def set_role_from_hidden_param
    if user_signed_in? && params[:hidden] == "worker"
      current_user.role = "worker"
      current_user.save
    elsif user_signed_in? && current_user.role == "customer"
      customer = Customer.create(user_id: current_user.id)
      current_user.role = "customer"
      current_user.save

    end
  end
end
