class ApplicationController < ActionController::Base
  before_action :configure_sanitized_params, if: :devise_controller? 
  after_action :set_role_from_hidden_param, if: :devise_controller?

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit(:name, :phone, :address,:email, :password, :password_confirmation, worker_attributes: [:SSnumber, :age, :gender, :profile_picture, :from_date, :to_date])
     end
  end
  
  
  def set_role_from_hidden_param
    if user_signed_in? && params[:hidden] == "worker"
      current_user.role = "worker"
      current_user.save
    end
    if user_signed_in? && current_user.role == "customer"
      customer = Customer.create(user_id: current_user.id)
      current_user.save
      cart = Cart.create(customer_id: customer.id)
      cart.save
   end
  end

end




  