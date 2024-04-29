class WorkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
        if params[:status] == 'pending'
            @pending = true
            @workers = Worker.includes(:user).where(users: { role: :worker }, status: :pending)
        else
            @workers = Worker.includes(:user).where(users: { role: :worker }, status: :approved)
        end
  end


    def create
    end
    
    def show
      @worker=Worker.find_by(id: params[:id])
    end

    def destroy
      @worker=Worker.find(params[:id]) 
      if @worker && @worker.destroy 
         flash[:notice]="Worker deleted"
      else
         flash[:alert]="Could not delete worker"
      end

    end

    #filter the worker according to user need
    def by_skill
      id = params[:id]
      gender = params[:gender]
      from_date = params[:from_date]
      to_date = params[:to_date]
      shift = params[:shift]
      hour = params[:hour]
      @workers = Worker.joins(:worker_skills)
      .where(status: "approved", gender: gender, shift: shift)
      .where("from_date <= ? AND to_date >= ?", to_date, from_date)
      .where(worker_skills: { skill_id: id }) 
    end

    #approve the worker status
    def approve

      @worker = Worker.find(params[:id])
      if @worker.update(status: "approved")
        flash[:notice] = "Worker is 'approved'"
      else
        flash[:alert] = "Failed to approve"
      end
      redirect_to workers_path
    end

   #reject the worker status
    def reject

      @worker = Worker.find(params[:id])
      if @worker.update(status: "rejected")
        flash[:notice] = "Worker is'rejected'"
      else
        flash[:alert] = "Failed to reject"
      end
      redirect_to workers_path
    end
    
  
end