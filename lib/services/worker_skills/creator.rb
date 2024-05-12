module Services
    module WorkerSkills
      class Creator
        attr_reader :worker_skill
  
        def initialize(worker_skill_params, current_user)
          @worker_skill_params = worker_skill_params
          @current_user = current_user
        end
  
        def call
          unless check_if_skill_exist
            create_worker_skill
            return true
          end
          false
        end
  
        private
  
        def create_worker_skill
          permitted_values = @worker_skill_params
          worker = Worker.find_by(user_id: @current_user.id)
          values = { wage: permitted_values[:wage], experience: permitted_values[:experience], skill_id: permitted_values[:id], worker: worker }
          @worker_skill = WorkerSkill.create(values)
        end
  
        def check_if_skill_exist
          skill_id = @worker_skill_params[:id]
          worker = Worker.find_by(user_id: @current_user.id)
          WorkerSkill.exists?(skill_id: skill_id, worker_id: worker.id)
        end
      end
    end
  end