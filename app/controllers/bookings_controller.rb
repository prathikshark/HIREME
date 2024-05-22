
class BookingsController < ApplicationController
  before_action :check_worker_availability, only: [:update]

  def index
  end

  def create
  end

  def update
    booking = Booking.find_by(id: params[:id])
    if booking.update(booked: true)
      Services::BookingManager.mail(booking)
      redirect_to booking_confirmed_bookings_path
    end
  end

  def booking_confirmed
  end

  private

  def check_worker_availability
    message = Services::BookingManager.check(params[:id])
    if message
      flash[:alert] = message
      redirect_back(fallback_location: root_path)
    end
  end
  
end
