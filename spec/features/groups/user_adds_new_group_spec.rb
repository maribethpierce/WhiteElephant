require 'rails_helper'

feature 'user can add a new group', %{
  As a user
  I want to create a new group
  So that I can exchange gifts with my friends

  Acceptance Criteria
  [] User navigates to new group form
  [] User creates a group with a name and optional description

} do
  feature "User can create group" do

    before(:each) do
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    scenario "User can navigate to form from home page" do
      visit root_path
      click_link "My Groups"
      expect(page).to have_content("Create a Group")
    end

    scenario "User can see new group form" do
      visit root_path
      click_link "My Groups"
      click_link "Create a Group"

      expect(page).to have_content("Name")
      expect(page).to have_content("Description")

    end
  end

end
