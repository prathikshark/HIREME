class WorkersController < ApplicationController
    def index
      @users=User.all
      @workers = User.includes(:worker).where(role: :worker)
    end
    
    def new
    end

    def create

    end
end