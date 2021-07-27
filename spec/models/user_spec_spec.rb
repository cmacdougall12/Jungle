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

  describe '.authenticate_with_credentials' do
    
    it "user can log-in with proper credentials" do
    existing_user = User.create!({
      id: 1,
      name: 'Cam',
      email: 'a@a.com',
      password: 'password',
      password_confirmation: 'password'
    })

    user = User.authenticate_with_credentials('a@a.com', 'password')
    expect(user.id).to eq(1)
    end

    it "user can not log-in with incorrect credentials" do
      existing_user = User.create!({
        id: 1,
        name: 'Cam',
        email: 'a@a.com',
        password: 'password',
        password_confirmation: 'password'
      })
  
      user = User.authenticate_with_credentials('a@b.com', 'password')
      expect(user).to eq(nil)
      end

      it "user can login if there is white space at the beginning or end" do
        existing_user = User.create!({
          id: 1,
          name: 'Cam',
          email: 'a@a.com',
          password: 'password',
          password_confirmation: 'password'
        })
    
        user = User.authenticate_with_credentials('   a@a.com    ', 'password')
        expect(user.id).to eq(1)
        end


      it "user can login sucessfully if wrong case is given in email" do
        existing_user = User.create!({
          id: 1,
          name: 'Cam',
          email: 'a@a.com',
          password: 'password',
          password_confirmation: 'password'
        })
    
        user = User.authenticate_with_credentials('   A@A.com    ', 'password')
        expect(user.id).to eq(1)
        end
      
    
  end
  
  end