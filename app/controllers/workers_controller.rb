class WorkersController < ApplicationController
  skip_before_action :verify_authenticity_token

    def index
      @workers = Worker.joins(:user).where(users: {role: :worker})      
    end
    
    def new

    end

    def create
    end
    
    def show
      @worker=Worker.find_by(id: params[:id])
    end

    def destroy
      @user=User.find(params[:id]) 
      if @user && @user.destroy 
         flash[:notice]="Worker deleted"
      else
         flash[:alert]="Could not delete worker"
      end

    end

    def by_skill
     puts(params)
     id = params[:id]
     gender = params[:gender]
     from_date = params[:from_date]
     to_date = params[:to_date]
     shift = params[:shift]
     hour = params[:hour]
     
     puts "==========================================================================="
     @workers = Worker.joins(:worker_skills).where(worker_skills: { skill_id: id }).where(gender: gender).where("from_date <= ? AND to_date >= ?", to_date, from_date)


    end

    
end