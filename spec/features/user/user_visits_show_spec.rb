require 'rails_helper'

feature 'user can visit my show page', %{
  As a user
  I want to see my own page
  So that I can see lists of my groups

  Acceptance Criteria
  [] User sees list of their groups
  [] Listed groups are links to more information re: group
  [] User doesn't see other groups
} do
  feature "User visits their show page" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @group1 = FactoryGirl.create(:group)
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      visit new_user_group_path(@user.id)
      fill_in 'Name', with: @group1.name
      fill_in 'Description', with: @group1.description
      click_button 'Create a Group!'
    end

    scenario "User can navigate to their page from home page" do
      visit root_path
      click_link "My Groups"

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@group1.name)
      expect(page).to_not have_content(@group1.description)
    end

    scenario "User can click group names to navigate to group page" do
      visit root_path
      click_link "My Groups"
      click_link @group1.name

      expect(page).to have_content(@group1.name)
      expect(page).to have_content(@group1.description)
    end

    scenario "User can doesn't see other users groups" do
      visit root_path
      click_link "Sign Out"
      click_link "Sign Up"
      fill_in "Name", with: "Name"
      fill_in "Email", with: "email@email.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button 'Sign up'
      click_link "My Groups"

      expect(page).to have_content("Here are Name's groups:")
      expect(page).to_not have_content(@user.name)
      expect(page).to_not have_content(@group1.name)
    end
  end

end
