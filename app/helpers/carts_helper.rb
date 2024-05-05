module CartsHelper

    def render_cart_services(cart_services)
        if cart_services.present? 
          yield  
        end 
    end

    def render_content_if_cart_is_empty(cart_services)
        unless cart_services.present?  
          yield  
        end 
    end
    
end