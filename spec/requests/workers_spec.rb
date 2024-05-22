require 'rails_helper'

RSpec.describe WorkersController, type: :request do

  describe "GET /index" do
    let(:worker) {create(:user,:worker)}

    before(:each) do 
       sign_in worker
    end

    it "its a successful request" do 
      get workers_path
      expect(response).to have_http_status(:success)
    end

    it "render worker/index page" do
      get workers_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("workers/index")
    end
  end
    
  describe "DELETE /destroy" do
    let(:user) { create(:user) }
    let!(:worker) { create(:worker, user: user) }
    let(:workers_delete_path) { "/workers/#{worker.id}" }
  
    before(:each) do
      sign_in user
    end
  
    it "deletes the worker and redirects to workers_path" do
      expect { delete workers_delete_path}.to change(Worker, :count).by(-1)
      expect(flash[:notice]).to eq("Worker deleted")
      expect(response).to redirect_to(workers_path)
    end
  
    it "sets a flash alert if the worker could not be deleted" do
      allow_any_instance_of(Worker).to receive(:destroy).and_return(false)
      delete workers_delete_path
      expect(flash[:alert]).to eq("Could not delete worker")
      expect(response).to redirect_to(workers_path)
    end
  end


    describe "PATCH /approve" do
        let(:user) { create(:user) }
        let(:worker) { create(:worker, user: user) }

        before(:each) do
          sign_in user
        end

        it "updates the worker status to 'approved'" do
          patch approve_worker_path(worker)
          expect(worker.reload.status).to eq("approved")
        end
  end

  describe "PATCH /reject" do
    let(:user) { create(:user) }
    let(:worker) { create(:worker, user: user) }

    before(:each) do
      sign_in user
    end

    it "updates the worker status to 'rejected'" do
      patch reject_worker_path(worker)
      expect(worker.reload.status).to eq("rejected")
    end
 end

  describe "PATCH /update_status" do
    let(:user) { create(:user) }
    let(:worker) { create(:worker, user: user) }

    before(:each) do
      sign_in user
    end

    it "updates the worker status to 'pending' " do
      patch update_status_worker_path(worker)
      expect(worker.reload.status).to eq("pending")
    end
  end


  describe "PATCH /workers/:id" do
    let(:user) { create(:user) }
    let(:worker) { create(:worker, user: user) }
  
    before(:each) do
      sign_in user
    end

      it "updates the worker's details" do
        patch worker_path(worker), params: { worker: { shift: "Day" } }
        worker.reload
        expect(worker.shift).to eq("Day")
        expect(response).to have_http_status(302)
      end

      it "does not update the worker's details" do
        patch worker_path(worker), params: { worker: { shift: nil } }
        worker.reload
        expect(response).to redirect_to(worker_path(worker))
      end
   end
  
  describe "POST /workers/filter" do
    it "filters workers according to user needs" do
      post "/workers/filter", params: {
        skill_type: "Some Skill",
        from_date: "2024-05-20",
        to_date: "2024-05-25",
        day_night: "Night",
        hours_per_day: "8",
        timing: "8-5"
      }
      expect(response).to have_http_status(302)
    end 
  end
end


