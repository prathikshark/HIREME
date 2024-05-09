class SkillsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @skills = Skill.all
    end
    
    def new
      @skill=Skill.new
    end

    def create
        @skill=Skill.create(skill_parameter)
        if @skill.save
          flash[:notice]="Skill added"
        else
          flash[:alert]="Could not add skill"
        end
    end

    def destroy
        skill=Skill.find(params[:id])
        skill.destroy 
        
    end

    private
    def skill_parameter
        params.require(:skill).permit(:skill_type,worker_skill_attribute: %i[experience wage])
    end   
end