require 'rails_helper'

feature "As a userI want to get notified via email
letting me know whose name I drew" do
before(:each) do
  @user = FactoryGirl.create(:user)
  @user1 = FactoryGirl.create(:user)
  @user2 = FactoryGirl.create(:user)
  @user3 = FactoryGirl.create(:user)
  @user4 = FactoryGirl.create(:user)
  @user5 = FactoryGirl.create(:user)
  @group = FactoryGirl.create(:group)
  visit new_user_session_path
  fill_in 'Email', with: @group.user.email
  fill_in 'Password', with: @group.user.password
  click_button 'Log in'
end
  scenario "Email sent when names are drawn" do

    visit root_path
    click_link "My Groups"
    click_link @group.name
    click_link 'Add Group Members'
    check "#{@user1.name}"
    check "#{@user2.name}"
    check "#{@user3.name}"
    click_button "Add these members"
    click_link "Draw Names"
    click_button "Go!"
    expect(page).to have_content("Success! Pairs created!")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
