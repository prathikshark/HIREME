require "#{Rails.root}/lib/services/admin_service"

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

    def create
      admin_service = AdminServices::AdminService.new(params)
      if admin_service.create_admin
        flash[:notice] = "Admin added"
      else
        flash[:alert] = "Could not add admin"
      end
      render partial: "admins/each_admin", locals: { admin: @admin }
    end
  
    def edit
      @admin = User.find(params[:id])
    end
    
    def update
      admin_service = AdminServices::AdminService.new(params)
      if admin_service.update_admin(params[:id])
        flash[:notice] = "Admin was updated"
      else
        flash[:alert] = "Could not update admin"
      end
      redirect_to admins_list_path
    end
  
    private
  
    def admin_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation).merge(role: "admin")
    end
  end