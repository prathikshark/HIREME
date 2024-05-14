require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET #index" do
    it "assigns customers" do
      get customers_path
      expect(assigns(:users)).to eq(User.where(role: :customer))
    end

    it "renders the index template" do
      get customers_path
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #show" do
  let(:user) { create(:user) }
  let!(:customer) { create(:customer, user: user) }

  before(:each) do
    sign_in user
  end

  it "assigns the requested customer's bookings to @bookings" do
    booking1 = create(:booking, customer: customer, booked: true)
    booking2 = create(:booking, customer: customer, booked: false)

    get customer_path(customer)
    expect(assigns(:bookings)).to eq([booking1])
  end

  it "renders the show template" do
    get customer_path(customer)
    expect(response).to render_template(:show)
  end
end

 
  describe "DELETE #destroy" do
  let(:admin) { create(:user,:admin) }
  let(:user) { create(:user) }
  let!(:customer) { create(:customer, user: user) }
  let(:customers_delete_path) { "/customers/#{customer.id}" }

  before(:each) do
    sign_in admin
  end

  it "deletes the customer" do
    expect { delete customers_delete_path}.to change(Customer, :count).by(-1)
  end

end


end
