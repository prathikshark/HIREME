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
      gender = params[:gender]
      @filter_params = { 
        skill_type: params[:skill_type],
        from_date: params[:from_date],
        to_date: params[:to_date],
        shift: params[:day_night],
        hours_per_day: params[:hours_per_day].first.to_i,
        time: params[:timing]
      }

      @workers = Worker.includes(:worker_skills)
                      .where(status: "approved", gender: gender, shift: @filter_params[:shift])
                      .where("from_date <= ? AND to_date >= ?", @filter_params[:to_date], @filter_params[:from_date])
                      .where(worker_skills: { skill_id: Skill.where(skill_type: @filter_params[:skill_type]).pluck(:id) })

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
    
    def update_status
      @worker = Worker.find(params[:id])
      if @worker.update(status: 'pending')
        flash.now[:notice] = 'Request sent'
      else
        flash.now[:alert] = 'Failed to send request .Please try again.'
      end
      render :show
    end
end