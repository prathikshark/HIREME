module BookedServicesHelper

    def  render_if_cart_is_not_empty(booked_services)
      if booked_services&.any?
        yield  
        end 
    end

    def  render_if_cart_is_empty(booked_services)
      if booked_services.nil? || booked_services.empty?
        yield  
      end 
    end

    def check_if_rating_is_present(booked_service)
      if booked_service.rating.present?
          yield
      end
  end
  def check_if_rating_is_not_present(booked_service)
      unless booked_service.rating.present?
          yield
      end
  end
    
end