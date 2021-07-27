require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @user =User.create!({
      name: 'Cam',
      email: 'a@a.com',
      password: 'password',
      password_confirmation: 'password'
    })
  end

  scenario "User will login using correct credentials, and be re-directed to the home page" do
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    find_button('Submit').click
    expect(page).to have_content('Cam')
  end

  scenario "User will login using in-correct credentials, and remain at the login page" do
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: "nope"
    find_button('Submit').click
    expect(page).to_not have_content('Cam')
  end
end