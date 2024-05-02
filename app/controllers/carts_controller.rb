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
# app/controllers/carts_controller.rb
            cart = current_user.customer.cart
            booking = Booking.create(customer_id:  current_user.customer.id)
            cart.cart_services.each do |cart_service|
            booking.booked_services.create(cart_service.attributes.slice( 'worker_id', 'from_date', 'to_date', 'skill_type', 'shift', 'time', 'hour_per_day', 'wage'))
        end
            # Optionally, you can clear the cart after the booking is created
            cart.cart_services.destroy_all
            redirect_to request.referer

        end
        
end
