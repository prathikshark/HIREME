class CustomersController < ApplicationController
    def index
      @customers = User.where(role: :customer)
    end
    
    def new
    end

    def create

    end
end