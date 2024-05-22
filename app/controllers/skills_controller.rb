class SkillsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @skills = Skill.all
  end
  
  def new
    @skill=Skill.new
  end

  def destroy
    skill=Skill.find(params[:id]) 
    skill.destroy
    render plain:"deleted"
  end

  private
  def skill_parameter
      params.require(:skill).permit(:skill_type,worker_skill_attribute: %i[experience wage])
  end   
end