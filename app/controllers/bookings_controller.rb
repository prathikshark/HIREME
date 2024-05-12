class BookingsController < ApplicationController
  before_action :check_worker_availability, only: :update_booked

  def index
  end
  
  def show
    id = params[:id]
    @current_booking = Booking.find_by(id: id, booked: false)
    if @current_booking
        @current_cart_services = @current_booking.booked_services
    end
  end

  def create

  end
 
  def update_booked
      Booking.find_by(id: params[:id]).update(booked: true)
      redirect_to  booking_confirmed_bookings_path
  end

  def booking_confirmed
  
  end
  
    #email
  def confirm(cart)
    cart.cart_services.each do |cart_service|
      worker = Worker.find_by(id: cart_service.worker_id)
      WorkerMailer.confirmation_email(worker).deliver_now if worker
    end
  end    

  private
  def check_worker_availability
    booking = Booking.find_by(id: params[:id])

    booked_services = booking.booked_services
  
    booked_services.each do |booked_service|
      worker = booked_service.worker
      from_date = booked_service.from_date
      to_date = booked_service.to_date

      if Booking.joins(:booked_services)
                .where(booked: true, 'booked_services.worker_id': worker.id)
                .where('booked_services.from_date <= ?', to_date)
                .where('booked_services.to_date >= ?', from_date)
                .exists?
        flash[:alert] = " #{worker.user.name} is already booked for the specified date range. Please select other worker."
        redirect_back(fallback_location: root_path)
        return
      end
    end
  end
  
  
end
