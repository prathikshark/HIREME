class CartsController < ApplicationController
    before_action :authenticate_user!

    def index
    end
    
    def show
       @cart_services = Customer.find_by(id: params[:id]).cart.cart_services
    end

    def create

    end

    def destroy
        cart = current_user.customer.cart
        booking = Booking.create(customer_id: current_user.customer.id)
      
        cart.cart_services.each do |cart_service|
          from_date = cart_service.from_date
          to_date = cart_service.to_date
      
          # Creating Unavailability  for each date in the range
          (from_date..to_date).each do |date|
            Unavailability.create(worker_id: cart_service.worker_id, unavailable_date: date)
          end
      
          # Creating BookedService for date range
          booking.booked_services.create(cart_service.attributes.slice('worker_id', 'from_date', 'to_date', 'skill_type', 'shift', 'time', 'hour_per_day', 'wage'))
        end
      
        # Destroy CartService  after the save
        cart.cart_services.destroy_all
      
        redirect_to request.referer
      end
        
end
