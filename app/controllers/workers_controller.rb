class WorkersController < ApplicationController
    def index
      @users = User.where(role: :worker)
    end
    
    def new

    end

    def create
    end
    
    def show
      @user=User.find_by(id: params[:id])
    end

    def destroy
      @user=User.find(params[:id]) 
      if @user && @user.destroy 
         flash[:notice]="Worker deleted"
      else
         flash[:alert]="Could not delete worker"
      end

    end
    
end