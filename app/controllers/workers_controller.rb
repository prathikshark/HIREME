class WorkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:status] == 'pending'
      @workers = Worker.joins(:user).where(users: { role: :worker, status: :pending })
    else
      @workers = Worker.joins(:user).where(users: { role: :worker })
    end
  end
  
    
    def new

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

    def approve
      @worker = Worker.find(params[:id])
      if @worker.status =='approved' 
        flash[:alert] = "Worker status already  'approved'"
      elsif @worker.update(status: "approved")
        flash[:notice] = "Worker status updated to 'approved'"
      else
        flash[:alert] = "Failed to update worker status"
      end
      redirect_to workers_path
    end
    
  
end