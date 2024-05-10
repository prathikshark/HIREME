class BookedServicesController < ApplicationController
  
  def create
      worker_id = params[:worker_id]
      filter_params = params[:filter_params]
      if filter_params
            current_booking = current_user.customer.bookings.last
            if current_booking.booked == false && current_booking.booked_services.exists?(skill_type: filter_params[:skill_type])
              flash[:alert] = "Service already added"
            else
              #calculate wage of each worker   
              skill_id = Skill.find_by(skill_type: filter_params[:skill_type]).id
              worker_skill = WorkerSkill.find_by(worker_id: worker_id, skill_id: skill_id)
              worker_wage = worker_skill.wage.to_i
              
              from_date = Date.parse(filter_params[:from_date])
              to_date = Date.parse(filter_params[:to_date])
              date_difference = (to_date - from_date).to_i 
              wage = date_difference * worker_wage

              booked_service = current_booking.booked_services.create(booking_service_params.merge(wage: wage))

              if booked_service.save
                flash[:notice] = "Service added"
              else
                flash[:alert] = "Could not add service"
              end
            end
      else
          flash[:alert] = "Apply the filter first"
      end
      redirect_to request.referer
  end

  def destroy
        booked_service = BookedService.find_by(id: params[:id])
        if booked_service && booked_service.destroy
          flash[:notice] = "Service removed"
        else
          flash[:alert] = "Could not remove service"
        end
        redirect_to request.referer
  end

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
          redirect_to request.referer
  end



   private
    def booking_service_params
      params.require(:filter_params).permit(:from_date, :to_date, :hour_per_day, :skill_type, :shift, :time)
            .merge(worker_id: params[:worker_id])
    end
    
    def booked_service_params
      params.require(:booked_service).permit(:comment, :rating)
    end

end
   























