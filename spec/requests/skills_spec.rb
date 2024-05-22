require 'rails_helper'

RSpec.describe "Admins", type: :request do

  describe "GET /index" do 

    it "is successful request" do 
      get admins_path
      expect(response).to have_http_status(:success)
    end

    it "render admins/index page" do 
      get admins_path
      expect(response).to render_template("admins/index")
    end
  end


  describe "GET /admins_list" do
  
    it "is successful request" do 
      get admins_list_path
      expect(response).to have_http_status(:success)
    end

    it "render admins/index page" do 
      get admins_list_path
      expect(response).to render_template("admins/admin_list")
    end
  end

  describe "POST /create" do
 
    it "successfull creation of admin render admins/each_admin" do
      post admins_path(
        user:{
        name: "new_name",
        email: "praneeth@gmail.com",
        password: "password"
      })
      expect(response).to render_template("admins/_each_admin")
    end

     it "render new if fail" do
      #invalid pasword
      post admins_path(
        user:{
        name: "new_name",
        email: "praneeth@gmail.com",
        password: "pass"
      })
      expect(response.body).to eq("admin not created")
    end

  end

  describe "GET /edit" do
     let(:user) { create(:user,role: "admin") }
    
    it "is successful request" do 
      get edit_admin_path(user.id)
      expect(response).to have_http_status(:success)
    end

    it "render admins/edit page" do 
      get edit_admin_path(user.id)
      expect(response).to render_template("admins/edit")
    end
  end

    describe "PATCH /update" do    
    let(:user) { FactoryBot.create(:user ,role:"admin") }

    it "successfull updation" do 
      #edit name
      patch admin_path(
        user,
        user: {
        name: "new_name",
        email: user.email,
        password: user.password

      })
      expect(response).to redirect_to(admins_list_path)
    end


    it "successfull updation" do 
      #edit name
      patch admin_path(
        user,
        user: {
        name: "new_name",
        email: "invalid",
        password: user.password

      })
      expect(response).to render_template("edit")
    end

  end
end