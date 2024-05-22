require 'rails_helper'

RSpec.describe "Customers", type: :request do

  describe "GET /index" do 
    it "is successful request" do 
      get customers_path
      expect(response).to have_http_status(:success)
    end

    it "render customers/index page" do 
      get customers_path
      expect(response).to render_template("customers/index")
    end
  end


  describe "GET /show" do
      let(:user) { FactoryBot.create(:user,role: "customer") }
      let(:customer) { FactoryBot.create(:customer,user: user) }
      
      it "is successful request" do
        get customer_path(customer)
        expect(response).to have_http_status(:success)
      end    
  end

  describe "DELETE /destroy" do
    let(:user) { FactoryBot.create(:user,role: "customer") }
    let(:customer) { FactoryBot.create(:customer, user: user)}
    
    it "successful customer deletion" do
      delete customer_path(
        customer
        )
        expect(response).to have_http_status(200)
        expect(response.body).to eq("customer deleted")
    end

    it "set flash saying 'could not delete customer'" do
          allow_any_instance_of(Customer).to receive(:destroy).and_return(false)
          delete customer_path(customer)
          expect(flash[:alert]).to eq("Could not delete customer")
          expect(response).to redirect_to(customers_path)
    end
  end

end