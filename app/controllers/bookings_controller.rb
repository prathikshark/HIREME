class BookingsController < ApplicationController

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
      booking = Booking.create(customer_id: current_user.customer.id)
      booking.save
    end
   
    def update_booked
       current_booking_id = params[:id]
       current_booking = Booking.find_by(id: current_booking_id)
       current_booking.update(booked: true)
       create
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
 
end
