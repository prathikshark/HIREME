module Services
    module Admin

        class Creator
         attr_reader :errors

            def initialize(params, admin_class = Admin)
                @params = params 
                @errors = nil
                @admin_class = admin_class
            end

            def call
                admin = @admin_class.new(@params)
                if admin.save
                    return true
                else
                    errors = admin.errors.full_messages
                    return errors
                end
            end  
        end
    end
end
