class WorkerSkillsController < ApplicationController    
  skip_before_action :verify_authenticity_token

  def index
    @worker_skills = WorkerSkill.all
  end

  def create 
    service = Services::WorkerSkillManager.new(worker_skill_params, current_user)
    if service.create_worker_skill
      render partial: "worker_skills/each_worker_skill", locals: { worker_skill: service.worker_skill }
    end
  end
  
  def edit

  end
  
  def update
  
  end

  def destroy
    worker_skill = WorkerSkill.find_by(id: params[:id]).destroy
    redirect_to request.referer
  end


  private
    def worker_skill_params
        params.require(:worker_skill).permit(:id, :experience,:wage)
    end
end