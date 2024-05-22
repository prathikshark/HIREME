class AdminsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_admin, only: [:edit, :update]

  def index

  end
  
  def admin_list
      @admins = User.where(role: :admin)
      @user = User.new()
  end

  def create
      @admin = User.create(admin_parameters)
      # debugger
      if @admin.save
        flash[:notice] = "Admin added"
        render partial: "admins/each_admin",locals:{admin:@admin}
      else
        # debugger
        flash[:alert] = "Could not add admin. "
        render plain:"admin not created"
      end
  end
    
  def edit
  end

  def update
    if @admin.update(admin_parameters)
      # debugger
      flash[:notice] = "Admin was updated"
      redirect_to admins_list_path
    else
      flash[:alert] = "Could not update"
      render :edit
    end
  end

  private
  def admin_parameters
      params.require(:user).permit(:name,:email,:password).merge(role:"admin")
  end  
  
  def set_admin
      @admin = User.find(params[:id])
  end
end