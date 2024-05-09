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
      @admin = User.create(name:params[:name],email:params[:email],password:params[:password],role:2)
      if @admin.save
        flash[:notice] = "Admin added"
      else
        flash[:alert] = "Could not add admin"
      end
      render partial: "admins/each_admin",locals:{admin:@admin}
  end
    
  def edit
      @admin = User.find(params[:id])
  end

  def update
      @admin = User.find(params[:id])
      if @admin.update(admin_parameters)
        flash[:notice] = "Admin was updated"
      else
        flash[:alert] = "Could not update"
      end
      redirect_to admins_list_path
  end

  private
  def admin_parameters
      params.require(:user).permit(:name,:email,:password,:password_confirmation).merge(role: "admin")
  end    
    
end