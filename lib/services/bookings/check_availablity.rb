module Services
    module Bookings
      class CheckAvailablity

        def self.check_worker_availability(booking_id)
          booking = Booking.find_by(id: booking_id)
          return unless booking
  
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
              return "#{worker.user.name} is already booked for the specified date range. Please select another worker."
            end
          end
          nil
          
        end
      end
    end
  end
  