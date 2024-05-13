require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    
    it "requires a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "requires an address" do
      user = build(:user, address: nil)
      expect(user).not_to be_valid
    end

    it "requires a phone number" do
      user = build(:user, phone: nil)
      expect(user).not_to be_valid
    end

    it "requires a phone number to be numerical" do
      user = build(:user, phone: "abc")
      expect(user).not_to be_valid
    end

    it "requires a phone number to be exactly 10 digits long" do
      user = build(:user, phone: "12345678901")
      expect(user).not_to be_valid
    end
  end
end
