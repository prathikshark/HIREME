module Services
    class BookingManager

        def self.mail(booking)
            Services::Bookings::SendEmail.send_mail(booking)
        end

        def self.check(booking)
            Services::Bookings::CheckAvailablity.check_worker_availability(booking)
        end
    end
end