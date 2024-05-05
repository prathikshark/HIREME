module ApplicationHelper

    def check_user_present(current_user)
        if current_user
          yield  
        end 
    end
    def if_user_not_present(current_user)
        unless current_user
          yield  
        end 
    end

    def if_current_user_customer(current_user)
        if current_user.role == 'customer' 
          yield  
        end 
    end

    def if_current_user_worker(current_user)
        if current_user.role == "worker" && current_user.worker.present?     
          yield  
        end 
    end

    def if_current_user_admin(current_user)
        if current_user.role == 'admin' 
            yield  
        end 
    end

    def if_profile_picture_attached(user)
        if user.profile_picture.attached?
            yield  
        end 
    end

    def if_profile_picture_not_attached(user)
        unless user.profile_picture.attached?
            yield  
        end 
    end

end
