class AdminsController < ApplicationController
    def index

    end

    def admin_list
        @admins = User.where(role: :admin)
        @user = User.find(current_user.id)
    end

    def new
    end

    def create
        @admin=User.create(admin_parameters)
         if @admin.save
            flash[:notice]="Admin added"
         else
            flash[:alert]="Could bot add admin"
         end
    end

    def edit

    end

    private
    def admin_parameters
        params.require(:user).permit(:name,:email,:password).merge(role: "admin")
    end    
      
end
