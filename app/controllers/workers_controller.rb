class WorkersController < ApplicationController
    def index
      @workers = User.where(role: :worker)
    end
    
    def new

    end

    def create

    end
    
    def show
      @user=User.find_by(id: current_user.id)
      @worker_skill = @user.worker.worker_skills

    end

    
end