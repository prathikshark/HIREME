# lib/admin_service.rb
module AdminServices
    class AdminService
      def initialize(params)
        @params = params
      end
  
      def create_admin
        @admin = User.create(name: @params[:name], email: @params[:email], password: @params[:password], role: 2)
        if @admin.save
          "Admin added"
        else
          "Could not add admin"
        end
      end
  
      def update_admin(id)
        @admin = User.find(id)
        if @admin.update(admin_parameters)
          "Admin was updated"
        else
          "Could not update"
        end
      end
  
      private
  
      def admin_parameters
        @params.require(:user).permit(:name, :email, :password, :password_confirmation).merge(role: "admin")
      end
    end
  end
  