module WorkersHelper

    def if_request_pending(pending)
        if pending
          yield  
        end 
    end
    def if_status_rejected(worker)
        if worker.status == "rejected"
            yield  
        end 
    end

end