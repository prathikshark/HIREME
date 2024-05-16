module Services
    module Bookings
      class SendEmail

        def self.send_mail(booking)
            booking.booked_services.each do |booked_service|
              worker = Worker.find_by(id: booked_service.worker_id)
              WorkerMailer.confirmation_email(worker, booked_service.from_date, booked_service.to_date, booked_service.skill_type).deliver_later
            end
        end
      end
    end
end    