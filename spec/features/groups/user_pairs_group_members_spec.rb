require 'rails_helper'

feature 'user can pair the members of their groups', %{
  As a user
  I want to pair members of my group
  So that each person is a santa and a recipient

  Acceptance Criteria
  [] User gets confirmation that pairs have been created
  [] User can't create pairs once they're created
  [] User can send emails to all members with pair information

} do
  feature "User can pair the members of their groups" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @group = FactoryGirl.create(:group)
      visit new_user_session_path
      fill_in 'Email', with: @group.user.email
      fill_in 'Password', with: @group.user.password
      click_button 'Log in'
    end

    scenario "User can create pairs" do
      visit root_path
      click_link "My Groups"
      click_link "#{@group.name}"
      click_link "Draw Names"
      expect(page).to have_content("Clicking \"Go!\" can\'t be undone")
    end

    scenario "User gets confirmation that pairs have been created" do
      visit root_path
      click_link "My Groups"
      click_link @group.name
      click_link 'Add Group Members'
      check(@user.name)
      check(@user1.name)
      check(@user2.name)
      click_button 'Add these members'
      click_link "Draw Names"
      save_and_open_page
      click_button "Go!"
      expect(page).to have_content("Success! Pairs created!")

      click_link "Draw Names"
      expect(page).to have_content("Pairs already created for this group")
    end

    # scenario "User can't create pairs once they're created" do
    #   visit root_path
    #   click_link "My Groups"
    #   click_link (@group.name)
    #   click_link "Draw Names"
    #   expect(page).to have_content("Pairs already created for this group")
    # end

    scenario "User can send emails to all members with pair information" do
      visit root_path
      click_link "My Groups"
      click_link @group.name
      click_link 'Add Group Members'
      check(@user.name)
      check(@user1.name)
      check(@user2.name)
      click_button 'Add these members'

      expect(page).to have_content('Members added!')
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end
  end
end
