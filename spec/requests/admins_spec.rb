require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET #admin_list" do
    it "assigns admins" do
      get admins_list_path	
      expect(assigns(:admins)).to eq(User.where(role: :admin))
    end

    it "assigns a new user" do
      get admins_list_path	
      expect(assigns(:user)).to be_a_new(User)
    end

    it "rendering admins_list template" do
      get admins_list_path	
      expect(response).to render_template(:admin_list)
    end
  end
  
  describe "POST /admins" do
    let(:admin) { create(:user, :admin) }

    before(:each) do
      sign_in admin
    end

    it "creates a new admin with valid parameters" do
      post admins_path, params: { user: { name: "New Admin", email: "newadmin@example.com", password: "password" } }
      expect(response).to render_template("admins/_each_admin")
    end

    # it "does not create a new admin with invalid parameters" do
    #   post admins_path, params: { user: { name: nil, email: "invalid_email", password: "" } }
    #   expect(response).to render_template(:new)
    # end
  end

  describe "PATCH /admins/:id" do
    let(:user) { create(:user, :admin) }
  
    before(:each) do
      sign_in user
    end
  
    context "with valid parameters" do
        it "updates the admin's details" do
          patch admin_path(user), params: { user: { name: "NEW ADMIN" } }
          user.reload
          expect(user.name).to eq("NEW ADMIN")
          expect(response).to have_http_status(302)
        end
      end
  
      context "with invalid parameters" do
        it "does not update the admin's details" do
          patch admin_path(user), params: { user: { email: nil } }
          user.reload
          expect(user.email).not_to be_nil
          expect(response).to render_template(:edit)
        end
      end
    end

end


