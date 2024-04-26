class AdminsController < ApplicationController
    def index
        @admin_count = User.where(role: 'admin').count
        @worker_count = User.where(role: 'worker').count
        @customer_count = User.where(role: 'customer').count
        @skill_count = Skill.count
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
            flash[:alert]="Could not add admin"
         end
    end

    def edit

    end

    private
    def admin_parameters
        params.require(:user).permit(:name,:email,:password).merge(role: "admin")
    end    
      
end
