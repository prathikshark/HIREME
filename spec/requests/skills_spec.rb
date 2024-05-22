require 'rails_helper'

RSpec.describe "Skills", type: :request do

  describe "GET /index" do 

    it "is successful request" do 
      get skills_path
      expect(response).to have_http_status(:success)
    end

    it "render admins/index page" do 
      get skills_path
      expect(response).to render_template("skills/index")
    end
  end

  describe "DELETE /destroy" do
    let(:skill) { FactoryBot.create(:skill) }
   
    # debugger
    it "deletes the skill succesfully" do
      delete skill_path(skill)
      expect(response.body).to eq("deleted")
      
    end
  end
end