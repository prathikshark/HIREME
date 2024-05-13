# require 'rails_helper'

# RSpec.describe WorkersController, type: :request do
#   include Devise::Test::IntegrationHelpers

#   describe 'GET /index' do
#     it 'renders the worker index page after signing in' do
#       user = FactoryBot.create(:user)
#       sign_in user
#       get workers_path
#       expect(response).to render_template(:index)
#     end
#   end
# end


require 'rails_helper'

RSpec.describe WorkersController, type: :request do

  describe "GET /index" do
    let(:worker) {create(:user,:worker)}

    before(:each) do 
       sign_in worker
    end

    it "render worker/index page" do
      get workers_path
      expect(response).to have_http_status(200)
      expect(response).to render_template("workers/index")
    end
    end
    
    describe "DELETE #destroy" do
      let(:worker) { create(:worker) }
      let(:workers_delete_path) {"/workers/#{worker.id}"}

      before(:each) do
        sign_in worker.user
      end 

      it "deletes the worker and redirects to workers_path" do
        delete workers_delete_path
        expect(response).to have_http_status(302)
      end
    end



    describe "PATCH /update" do 
    let(:test_worker) { create(:worker) }

    before(:each) do
      sign_in (test_worker.user)
      test_worker.update(status: "pending")
    end

    it "is not a successful request" do
      patch approve_worker_path(test_worker)
      expect(response).to_not have_http_status(:success)
    end
  end

end


