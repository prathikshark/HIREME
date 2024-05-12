module Services
    class WorkerSkillManager
      attr_reader :worker_skill
  
      def initialize(worker_skill_params, current_user)
        @worker_skill_params = worker_skill_params
        @current_user = current_user
      end
  
      def create_worker_skill
        creator = WorkerSkills::Creator.new(@worker_skill_params, @current_user)
        if creator.call
          @worker_skill = creator.worker_skill
          return true
        end
        false
      end
    end
  end