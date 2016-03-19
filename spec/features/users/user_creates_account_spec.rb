require 'rails_helper'

feature 'user creates an account' do

  before :each do
    visit new_user_registration_path
  end

  scenario "user specifies valid and required info" do
    user = FactoryGirl.create(:user)
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "example@example.com"
    fill_in "Phone Number", with: user.phone_number
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password

    click_button "Sign Up"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
  end

  scenario "user does not provide required information" do
    user = FactoryGirl.create(:user)
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
  end

  scenario "user's password does not match confirmation" do
    user = FactoryGirl.create(:user)
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Phone Number", with: user.phone_number
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: "Bananas"

    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
