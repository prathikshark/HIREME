require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe "validations" do

    it "has a user" do
        data = create(:worker)
        expect(data.user).to be_a(User)
    end

    it "requires a SSN (Social Security Number)" do
      worker = build(:worker, SSnumber: nil)
      expect(worker).not_to be_valid
    end

    it "requires a gender" do
      worker = build(:worker, gender: nil)
      expect(worker).not_to be_valid
    end

    it "requires an age" do
      worker = build(:worker, age: nil)
      expect(worker).not_to be_valid
    end

    it "requires a from_date" do
      worker = build(:worker, from_date: nil)
      expect(worker).not_to be_valid
    end

    it "requires a to_date" do
      worker = build(:worker, to_date: nil)
      expect(worker).not_to be_valid
    end

    it "requires a shift" do
      worker = build(:worker, shift: nil)
      expect(worker).not_to be_valid
    end

    it "requires a date of birth" do
      worker = build(:worker, date_of_birth: nil)
      expect(worker).not_to be_valid
    end
  end
end
