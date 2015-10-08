require 'rails_helper'

feature 'user can add members to their group', %{
  As a user
  I want to add members to my group
  So that I can see all my friends listed

  Acceptance Criteria
  [] User navigates to group show page
  [] User adds members to their group
  [] User sees a list of all group members
  [] Group creator can delete users from the list

} do
  feature "User can create group" do

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

    scenario "User can navigate to group show page" do
      visit root_path
      click_link "My Groups"
      expect(page).to have_content(@group.name)
    end

    scenario "User can see group information" do
      visit root_path
      click_link "My Groups"
      click_link (@group.name)

      expect(page).to have_content(@group.name)
      expect(page).to have_content(@group.description)
    end

    scenario "User adds members to group" do
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
