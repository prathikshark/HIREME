class BookingsController < ApplicationController
  before_action :check_worker_availability, only: [:update_booked]

  def index

  end
  
  def create

  end
  
  def update_booked
    booking = Booking.find_by(id: params[:id])
    if booking.update(booked: true)
      send_mail(booking)
      redirect_to booking_confirmed_bookings_path
    end
  end
  
  
  def booking_confirmed
  
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
  def send_mail(booking)
    booking.booked_services.each do |booked_service|
      worker = Worker.find_by(id: booked_service.worker_id)
      WorkerMailer.confirmation_email(worker, booked_service.from_date, booked_service.to_date, booked_service.skill_type).deliver_now
    end
  end
  
end
