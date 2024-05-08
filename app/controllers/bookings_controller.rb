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
       confirm(cart)
       create
       redirect_to  booking_confirmed_bookings_path
    end

    def booking_confirmed
    
    end
    
    # def destroy
    #     cart = current_user.customer.cart
    #     booking = Booking.create(customer_id: current_user.customer.id)
      
    #     cart.cart_services.each do |cart_service|
    #         from_date = cart_service.from_date
    #         to_date = cart_service.to_date
    #         # Creating Unavailability  for each date in the range
    #         (from_date..to_date).each do |date|
    #             Unavailability.create(worker_id: cart_service.worker_id, unavailable_date: date)
    #         end
    #         # Creating BookedService for date range
    #         booking.booked_services.create(cart_service.attributes.slice('worker_id', 'from_date', 'to_date', 'skill_type', 'shift', 'time', 'hour_per_day', 'wage'))
    #     end

    #     confirm(cart)
    #     # Destroy CartService  after the save
    #     cart.cart_services.destroy_all
    #     redirect_to request.referer
    #   end

      #email
      def confirm(cart)
        cart.cart_services.each do |cart_service|
          worker = Worker.find_by(id: cart_service.worker_id)
          WorkerMailer.confirmation_email(worker).deliver_now if worker
        end
      end    
 
end
