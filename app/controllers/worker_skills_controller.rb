class WorkerSkillsController < ApplicationController    
  before_action -> { check_if_skill_exist(current_user) }, only: [:create]

  def index
    @worker_skills = WorkerSkill.all
  end

  def create 
    permitted_values = worker_skill_params()
    worker= Worker.find_by(user_id: current_user.id)
    values = {wage:permitted_values[:wage], experience:permitted_values[:experience] , skill_id:permitted_values[:id], worker: worker}
    @worker_skill = WorkerSkill.create(values)

    if @worker_skill.save()
      flash[:notice]="Skill added"
    else
      puts(@worker_skill.errors.full_messages.to_sentence)
      flash[:alert]="Could not add skill"
      redirect_to worker_path(id: current_user.id)
    end

    
  end

  def edit

  end
  
  def update
  
  end

  def destroy
    @worker_skill = WorkerSkill.find_by(params[:id])

    if @worker_skill &&  @worker_skill.destroy
      flash[:notice]="Skill deleted"
    else
      flash[:alert]="Could not remove skill"
    end
  end


  private
    def worker_skill_params
        params.require(:worker_skill).permit(:id, :wage, :experience)
    end

    def check_if_skill_exist(current_user)
      permitted_values = worker_skill_params()
      skill_id = permitted_values[:id]
      worker = Worker.find_by(user_id: current_user.id)
      skill_present = WorkerSkill.find_by(skill_id: skill_id, worker_id: worker.id)
      if skill_present
        flash[:alert] = "Skill already exists!"
        redirect_to worker_path(id: worker.id)
      end
    end
    
end