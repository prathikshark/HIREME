class WorkersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_customer_role, only: :by_skill

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
    
      @available_workers = Worker.includes(:worker_skills)
                                  .where(status: "approved", gender: gender)
                                  .where.not(id: unavailable_worker_ids)
                                  .where(worker_skills: { skill_id: Skill.where(skill_type: @filter_params[:skill_type]).pluck(:id) })
                                  .where("shift =? OR shift =?", @filter_params[:shift], "Both")
    end
    
       #approve the worker status
       def approve
        @worker = Worker.find(params[:id])
        if @worker.update(status: "approved")
          flash[:notice] = "Worker is 'approved'"
        else
          flash[:alert] = "Failed to approve"
        end
      end
  
     #reject the worker status
      def reject
        @worker = Worker.find(params[:id])
        if @worker.update(status: "rejected")
          flash[:notice] = "Worker is'rejected'"
        else
          flash[:alert] = "Failed to reject"
        end
        render partial: "workers/workers_table",locals:{workers:@workers}
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
    
    private
    
    def unavailable_worker_ids
      Unavailability.where("unavailable_date BETWEEN ? AND ?", @filter_params[:from_date], @filter_params[:to_date])
                    .pluck(:worker_id)
    end

    def check_customer_role
      if current_user.nil? 
        redirect_to new_user_session_path
      else
        unless current_user.role == "customer"
          flash[:alert] = "Only customers can access this functionality."
          redirect_to portal_path
        end
      end
    end
       
end

