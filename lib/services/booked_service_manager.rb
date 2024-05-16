module Services
    class BookedServiceManager

         def initialize(params,worker_id)
              @params = params
              @worker_id = worker_id
         end

        def calculate_wage
                  skill_id = Skill.find_by(skill_type: @params[:skill_type]).id
                  worker_skill = WorkerSkill.find_by(worker_id: @worker_id, skill_id: skill_id)
                  worker_wage =  worker_skill.wage.to_i
                  hour_per_day =  @params[:hours_per_day][0].to_i
                  from_date = Date.parse(@params[:from_date])
                  to_date = Date.parse(@params[:to_date])
                  if from_date != to_date
                     date_difference = (to_date - from_date)
                  else
                    date_difference = 1
                  end
                  wage = date_difference * worker_wage * hour_per_day
         end
    end
end