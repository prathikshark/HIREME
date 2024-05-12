module Services
    module Workers
        class FilterWorker
                
            def initialize(params,filter_params)
                @params = params
                @filter_params = filter_params
            end
        
            def call
                gender = @params[:gender]
                filter_params = @filter_params
                
                filtered_workers = Worker.includes(:worker_skills)
                .where(status: "approved", gender: gender)
                .where(worker_skills: { skill_id: Skill.where(skill_type: filter_params[:skill_type]).pluck(:id) })
                .where("shift = ? OR shift = ?", filter_params[:shift], "Both")
                .where.not(id: BookedService.joins(:booking)
                                        .where("bookings.booked = ?", true)
                                        .where("booked_services.from_date <= ? AND booked_services.to_date >= ?", filter_params[:to_date], filter_params[:from_date])
                                        .select(:worker_id)
                                )

                if @params[:wage_per_hour].present?
                wage_range = @params[:wage_per_hour]
                unless wage_range == "All"
                    wage_lower_limit, wage_upper_limit = case wage_range
                                                        when "0-200"
                                                        [0, 200]
                                                        when "201-500"
                                                        [201, 500]
                                                        when "501-1000"
                                                        [501, 1000]
                                                        when "above"
                                                        [1001, nil]
                                                        end
                    if wage_upper_limit.nil?
                    filtered_workers = filtered_workers.joins(:worker_skills).where("worker_skills.wage >= ?", wage_lower_limit)
                    else
                    filtered_workers = filtered_workers.joins(:worker_skills).where("worker_skills.wage BETWEEN ? AND ?", wage_lower_limit, wage_upper_limit)
                    end
                end
                end
        
                # Additional filtering   rating   here
        
                filtered_workers
            end
        end
    end
  end
  
  