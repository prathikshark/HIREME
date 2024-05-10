# lib/admin_service.rb
module AdminServices
  class AdminService
    def initialize(params)
      @params = params
    end

    def create_admin
      admin = User.create(admin_params)
      admin.save
    end

    def update_admin(id)
      admin = User.find_by(id: id)
     if  admin.update(admin_params)
       true
     else
       false
     end
    end

    private

    def admin_params
      @params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
