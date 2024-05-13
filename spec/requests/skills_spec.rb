require 'rails_helper'

RSpec.describe "Skills", type: :request do
  describe "POST/create" do
    it "Creates the skill by redirecting to skill#create" do
      Rails.application.load_seed
      user = User.find_by(email: "admin1@hireme.com")
      puts user.email
      sign_in user
      puts user.email
      user = post skills_path, params: { skill: { skill_type: "cooking" } }
      expect(response).to have_http_status(302)  
      # puts user.name
    end
  end
end
