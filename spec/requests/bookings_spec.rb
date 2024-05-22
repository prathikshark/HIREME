require 'rails_helper'

RSpec.describe "Bookings", type: :request do

  
  describe "PATCH /update_booked" do
    let(:user) { create(:user) }
    let(:customer) { create(:customer, user: user) }
    let(:booking) {create(:booking, customer: customer)}
    let(:booked_services) {create(:booked_services, booking: booking)}

    before(:each) do
      sign_in user
    end

    it "updates the booking booked to 'true' " do
      patch booking_path(booking)
      expect(booking.reload.booked).to eq(true)
    end
  end

end