class WorkerMailer < ApplicationMailer
    default from: 'prathikshark2002@gmail.com'

    def confirmation_email(worker)
        @worker = worker
        mail(to: @worker.user.email, subject: 'Confirmation Email')
    end      
end
