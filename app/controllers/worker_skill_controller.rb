class SkillsController < ApplicationController
    def index
      @worker_skills = WorkerSkills.all
    end
    
    def create
        @worker_skill=WorkerSkill.create(worker_skill_parameter)
         if @worker_skill.save
            flash[:notice]="Skill added"
         else
            flash[:alert]="Could not add skill"
         end
    end

    def edit

    end

    private
    def worker_skill_parameter
        params.require(:worker_skill).permit(:experience,:wage,skill_attributes: [:skill_type])
    end    
      
end