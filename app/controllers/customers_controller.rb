class CustomersController < ApplicationController
    def index
      @users = User.where(role: :customer)
    end
    
    def new
    end

    def create

    end

    def show
    
    end
    
    def destroy
      @user=User.find(params[:id]) 
      if @user && @user.destroy 
         flash[:notice]="Customer deleted"
      else
         flash[:alert]="Could not delete customer"
      end
    end
end