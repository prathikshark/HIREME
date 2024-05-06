class CustomersController < ApplicationController
    def index
      @users = User.where(role: :customer)
    end
    
    def new
    end

    def create

    end
    
    def edit
    end

    def show
      user = User.find(params[:id])
      @customer = user.customer
      @bookings = @customer.bookings

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