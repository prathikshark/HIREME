class BookedServicesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_customer_role, only: :create
  before_action :check_if_booking_present, only: :create
  
  def index
    if current_user.customer.bookings.any?
      if current_user.customer.bookings.last.booked == false
         @booked_services = current_user.customer.bookings.last.booked_services
         @current_booking =  current_user.customer.bookings.last
      end
    end
  end

  def create
      worker_id = params[:worker_id].to_i
      filter_params = params[:filter_params]
      if check_if_booking_present
        current_booking = Booking.create(customer_id: current_user.customer.id)
        current_booking.save
      else 
        current_booking = current_user.customer.bookings.last
      end

    if filter_params
         
          from_date = filter_params[:from_date].to_date
          to_date = filter_params[:to_date].to_date

          if from_date >  to_date
            flash[:alert] = "To date cannot be greater than from date"
          else

            booked_services = current_booking.booked_services
          
            # Specify the worker ID for which you want to check conflicts
          
            if  current_booking.booked_services.exists?(skill_type: filter_params[:skill_type])
                  flash[:alert] = "Service already added"
            
            elsif booked_services.any? { |bs| bs.worker_id == worker_id && (bs.from_date <= to_date && bs.to_date >= from_date) }
                    flash[:alert] = "There is a booking conflict for the selected worker and date range."
            else
                  
                  #calculate wage of each worker   
                  skill_id = Skill.find_by(skill_type: filter_params[:skill_type]).id
                  worker_skill = WorkerSkill.find_by(worker_id: worker_id, skill_id: skill_id)
                  worker_wage = worker_skill.wage.to_i
                  hour_per_day =  filter_params[:hours_per_day][0].to_i
                  from_date = Date.parse(filter_params[:from_date])
                  to_date = Date.parse(filter_params[:to_date])
                  if from_date != to_date
                     date_difference = (to_date - from_date)
                  else
                    date_difference = 1
                  end
                  wage = date_difference * worker_wage * hour_per_day

                  booked_service = current_booking.booked_services.create(booking_service_params.merge(wage: wage))

                  if booked_service.save
                    flash[:notice] = "Service added"
                  else
                    flash[:alert] = "Could not add service"
                  end
                end
              end
      else
          flash[:alert] = "Apply the filter first"
      end
      redirect_to request.referer
  end

  def destroy
        booked_service = BookedService.find_by(id: params[:id])
        booked_service.destroy
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

    def check_customer_role
      unless current_user.role == "customer"
        flash[:alert] = "Only custommer can access this functionality"
        redirect_to request.referer
      end
    end
    
    def check_if_booking_present
      #checking if already cart exist
         if  current_user.customer.bookings.any?
            if current_user.customer.bookings.last.booked == true
                return true
            end 
         else
              return true
         end
    end
end
   























