class WorkerMailer < ApplicationMailer
    default from: 'prathikshark2002@gmail.com'

    def confirmation_email(worker, from_date, to_date, skill_type)
        @worker = worker
        @from_date = from_date
        @to_date = to_date
        @skill_type = skill_type
        mail(to: @worker.user.email, subject: 'Booking Confirmation')
      end     
end
