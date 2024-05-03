class BookedServicesController < ApplicationController
    
    def edit
        @booked_service = BookedService.find(params[:id])
    end

    def update
      @booked_service = BookedService.find(params[:id])
      if @booked_service.update(booked_service_params)
        #calculate the average for the worker with particular skill
        average_rating = BookedService.where(worker_id: @booked_service.worker_id, skill_type: @booked_service.skill_type).where.not(rating: nil).average(:rating).to_f
    
        #finding the worker_skill for that skill and updating
        worker_skill = WorkerSkill.find_by(worker_id: @booked_service.worker_id, skill_id: Skill.find_by(skill_type: @booked_service.skill_type).id)
        worker_skill.update(rating: average_rating)
        
        flash[:notice]= 'Comment and rating updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def booked_service_params
      params.require(:booked_service).permit(:comment, :rating)
    end
  end
  