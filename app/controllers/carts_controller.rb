class CartsController < ApplicationController
    before_action :authenticate_user!

    def index
    end
    
    def show
       @cart_services = Customer.find_by(id: params[:id]).cart.cart_services
    end

    def create

    end
end
