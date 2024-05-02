class BookedServicesController < ApplicationController
    
    def edit
        @booked_service = BookedService.find(params[:id])
    end

    def update
      @booked_service = BookedService.find(params[:id])
      if @booked_service.update(booked_service_params)
        redirect_to customer_path, notice: 'Comment and rating updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def booked_service_params
      params.require(:booked_service).permit(:comment, :rating)
    end
  end
  