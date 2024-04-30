class AdminsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @admin_count = User.where(role: 'admin').count
        @worker_count = Worker.where(status: 'approved').count
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
        @admin = User.new(admin_parameters)
        if @admin.save
          flash[:notice] = "Admin added"
          render partial: 'admin', locals: { admin: @admin } # Render the updated admin card
        else
          flash[:alert] = "Could not add admin"
          render status: :unprocessable_entity
        end
      end
      

    def edit
        @admin = User.find(params[:id])
    end
    def update

    end

    private
    def admin_parameters
        params.require(:user).permit(:name,:email,:password).merge(role: "admin")
    end    
      
end
