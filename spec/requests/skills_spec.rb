require 'rails_helper'

RSpec.describe "Skills", type: :request do
  
  describe "DELETE /skills/:id" do
    let!(:skill) { create(:skill) }

    it "destroys the requested skill" do
      expect {
        delete skill_path(skill)
      }.to change(Skill, :count).by(-1)
    end
  end

  context "with valid parameters" do
    it "creates a new skill" do
      expect {
        post :create, params: { skill: { name: "Ruby on Rails" } }
      }.to change(Skill, :count).by(1)
    end

    it "redirects to the skills list" do
      post :create, params: { skill: { name: "Ruby on Rails" } }
      expect(response).to redirect_to(skills_url)
    end

    it "sets the flash notice" do
      post :create, params: { skill: { name: "Ruby on Rails" } }
      expect(flash[:notice]).to eq("Skill added")
    end
  end

  context "with invalid parameters" do
    it "does not create a new skill" do
      expect {
        post :create, params: { skill: { name: nil } }
      }.not_to change(Skill, :count)
    end

    it "sets the flash alert" do
      post :create, params: { skill: { name: nil } }
      expect(flash[:alert]).to eq("Could not add skill")
    end
  end

end