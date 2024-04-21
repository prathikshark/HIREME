class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    puts "IsAdmin: #{resource.isadmin?}"

    if resource.is_a?(User) && resource.isadmin?
      admins_path
    else
      root_path
    end
end
end