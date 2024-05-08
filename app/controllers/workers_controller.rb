class WorkersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :check_customer_role, only: :by_skill

  def index
     if current_user.role == 'admin'
        if params[:status] == 'pending'
            @pending = true
            @workers = Worker.includes(:user).where(users: { role: :worker }, status: :pending)
        else
            @workers = Worker.includes(:user).where(users: { role: :worker }, status: :approved)
        end
      else
            @workers = Worker.where(status: "approved")
      end
   end


    def create
    end
    
    def show
      @worker=Worker.find_by(id: params[:id])
      @bookings = @worker.bookings      
    end

    def destroy
      @worker=Worker.find(params[:id]) 
      if @worker && @worker.destroy 
         flash[:notice]="Worker deleted"
      else
         flash[:alert]="Could not delete worker"
      end
      redirect_to request.referer
    end

    #filter the worker according to user need
    def filter
        gender = params[:gender]
        @filter_params = {
          skill_type: params[:skill_type],
          from_date: params[:from_date],
          to_date: params[:to_date],
          shift: params[:day_night],
          hours_per_day: params[:hours_per_day].first.to_i,
          time: params[:timing]
        }
        @filtered_workers = Worker.includes(:worker_skills)
        .where(status: "approved", gender: gender)
        .where(worker_skills: { skill_id: Skill.where(skill_type: @filter_params[:skill_type]).pluck(:id) })
        .where("shift = ? OR shift = ?", @filter_params[:shift], "Both")
        .where.not(id: BookedService.select(:worker_id)
                                  .where("from_date <= :to_date AND to_date >= :from_date", from_date: @filter_params[:to_date], to_date: @filter_params[:from_date]))

                                          

        # rating and wage 
        if params[:wage_per_hour].present?
          wage_range = params[:wage_per_hour]
          unless wage_range == "All"
            wage_lower_limit, wage_upper_limit = case wage_range
                                                when "0-200"
                                                  [0, 200]
                                                when "201-500"
                                                  [201, 500]
                                                when "501-1000"
                                                  [501, 1000]
                                                when "above"
                                                  [1001, nil] # Use nil to represent no upper limit
                                                end
            if wage_upper_limit.nil?
              @filtered_workers = @filtered_workers.joins(:worker_skills).where("worker_skills.wage >= ?", wage_lower_limit)
            else
              @filtered_workers = @filtered_workers.joins(:worker_skills).where("worker_skills.wage BETWEEN ? AND ?", wage_lower_limit, wage_upper_limit)
            end
          end
      end
        
                          
      # if params[:rating].present?
      #   rating_range = params[:rating]
      #   if rating_range == "All"
      #     # Display all workers without any rating conditions
      #   else
      #     rating_lower_limit, rating_upper_limit = case rating_range
      #                                               when "5-4"
      #                                                 [3, 5]
      #                                               when "3-2"
      #                                                 [2, 3]
      #                                               when "below"
      #                                                 [nil, 2] # Use nil to represent no upper limit
      #                                               end
      #     if rating_lower_limit.nil?
      #       @filtered_workers = @filtered_workers.joins(:worker_skills).where("worker_skills.rating <= ?", rating_upper_limit)
      #     elsif rating_upper_limit.nil?
      #       @filtered_workers = @filtered_workers.joins(:worker_skills).where("worker_skills.rating >= ?", rating_lower_limit)
      #     else
      #       @filtered_workers = @filtered_workers.joins(:worker_skills).where("worker_skills.rating BETWEEN ? AND ?", rating_lower_limit, rating_upper_limit)
      #     end
      #   end
      # end                    
      render partial: "workers/filtered_workers", locals: { filtered_workers: @filtered_workers }
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


    def edit
      @worker = Worker.find(params[:id])
    end

    def update
      @worker = Worker.find(params[:id])
      if @worker.update(worker_parameters)
        flash[:notice] = "Detail was updated"
      else
        flash[:alert] = "Could not update"
      end
      render :show
    end

    private
    def worker_parameters
        params.require(:worker).permit(:age,:profile_picture,:from_date,:to_date,:educational_qualification,:marital_status,:language,:shift)
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