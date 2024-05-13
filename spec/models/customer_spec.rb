require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do

    it "has a user" do
        data = create(:customer)
        expect(data.user).to be_a(User)
    end
  end

end 