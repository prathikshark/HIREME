
class WorkersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :set_worker, only:[:show, :destroy, :approve, :reject, :update_status, :edit, :update]

    def index
      @pending = params[:status] == 'pending'
      @workers = Worker.includes(:user).where(users: { role: :worker }, status: @pending ? :pending : :approved)
    end

    def create
      
    end
      
    def show
      @bookings = @worker.bookings.where(booked: true)
    end

    def destroy 
      if @worker.destroy 
          flash[:notice]="Worker deleted"
      else
          flash[:alert]="Could not delete worker"
      end
      redirect_to request.referer
    end

    #approve the worker status
    def approve
      @worker.update(status: "approved")
    end

    #reject the worker status
    def reject
      @worker.update(status: "rejected")
    end

    def update_status
      if @worker.update(status: 'pending')
        flash.now[:notice] = 'Request sent'
      else
        flash.now[:alert] = 'Failed to send request .Please try again.'
      end
      render :show
    end

    def edit

    end

    def update
      if @worker.update(worker_parameters)
        flash[:notice] = "Detail was updated"
      else
        flash[:alert] = "Could not update"
      end
      render :show
    end

    #filter the worker according to user need
    def filter
      @filter_params = {
        skill_type: params[:skill_type],
        from_date: params[:from_date],
        to_date: params[:to_date],
        shift: params[:day_night],
        hours_per_day: params[:hours_per_day],
        timing: params[:timing]
      }

      @filtered_workers = Services::WorkerManager.new(params, @filter_params).filter_workers
      render partial: "workers/filtered_workers", locals: { filtered_workers: @filtered_workers }
    end

    private
    def worker_parameters
        params.require(:worker).permit(:age,:profile_picture,:from_date,:to_date,:educational_qualification,:marital_status,:language,:shift)
    end 
 
    def set_worker
      @worker = Worker.find_by(id: params[:id])
    end 
 
end