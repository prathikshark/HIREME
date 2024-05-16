module Services
    class BookingManager

        def mail(booking)
            Services::Bookings::SendEmail.send_mail(booking)
        end

        def check(booking)
            Services::Bookings::CheckAvailablity.check_worker_availability(booking)
        end
    end
end