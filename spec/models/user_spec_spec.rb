require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe 'Validations' do

    subject {
      User.create!({
        name: 'Cam',
        email: 'a@a.com',
        password: 'password',
        password_confirmation: 'password'
      })
    }
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid if the password_confirmation does not match the password field" do
      subject.password_confirmation = "wrong"
      expect(subject).to_not be_valid
    end

    it "is not valid if the password is undefined" do
      subject.password = nil
      expect(subject).to_not be_valid
    end


    it "is not valid if the password confirmation is not given" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if the user name is not given" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if another user is created with the same email" do
      new_user = User.create!({
        name: 'Cam',
        email: 'a@a.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect {User.create!({
        name: 'Cam',
        email: 'A@A.com',
        password: 'password',
        password_confirmation: 'password'
      })}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "is not valid if the password is less than 8 characters" do
      subject.password = 'only5'
      expect(subject).to_not be_valid
    end
    
  end
  
  end