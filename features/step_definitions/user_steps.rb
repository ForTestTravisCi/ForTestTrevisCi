require_relative '../pages/user_page'
require_relative '../pages/login_page'
require_relative '../pages/user_profile_page'
require_relative '../pages/user_profile_edit_page'

include UserPage
include LoginPage
include UserProfile
include UserProfileEdit


And(/^Admin click on USERS on header$/) do
  execute_script(%q($('.nav-label:contains("Users")').click();))
  sleep 2
end

When(/^Admin click button "ADD"$/) do
  click_link 'Add'
end

Then(/^Admin see window creation user$/) do
  has_text?('New user',count: 4)
end

And(/^Admin create new (.*)$/) do |user|
  create_new_user(user)
end

Then(/^(.*) confirm creation$/) do |user|
  user == user.downcase
  confirm_creation(user)
  sleep 3
  do_logout
  sleep 5
end

And(/^New (.*) verify that account created$/) do |user|
  login_new(user)
  have_info_message?('login')
  sleep 5
  do_logout
  sleep 5
end

When(/^Admin search (.*) name$/) do |user|
  click_link('Search')
  sleep 1
  search_new(user)
end

Then(/^Admin delete (.*)$/) do |user|
  delete_new(user)
  sleep 2
  # expect(Capybara.page).to have_info_message('user_deleted') # TODO: info message 'user_deleted'
end

When(/^New (.*) do login and should see login error message$/) do |user|
  login_new(user)
  having_error_text?('login')
end

And(/^Admin invite new student$/) do
  invite_student
end

Then(/^New student confirm invitation$/) do
  confirm_invitation
end


When(/^Admin click button "ADD" in GROUPS tab$/) do
  click_link('Groups')
  sleep 1
  click_link 'Add'
  has_text?('New group', count: 4)
end

Then(/^Admin create group$/) do
  create_group_on_user_page
end

And(/^Admin add student and assign course$/) do
  add_student_to_group
  assign_a_course
end

And(/^Admin should see created group in group list$/) do
  expect_group_added_to_course
end

Then(/^Admin deleting group$/) do
  delete_active_course('group')
  delete_group('user')
end


And(/^(.*) go to edit profile page$/) do |_user|
  sleep 1
  find('.profile-role').click
  sleep 1
  expect(Capybara.page).to have_link('Edit')
  click_link('Edit')
end

When(/^(.*) edit fields and click save$/) do |_user|
  # user == user.downcase
  edit_user_profile
  change_lang_edit_profile
  sleep 2
  change_lang_edit_profile
end

Then(/^(.*) should see changes in profile info$/) do |_user|
  # user == user.downcase
  expect_edited_changes
  change_back_profile
  do_logout
end

And(/^Admin go to user edit page and edit user profile$/) do
  execute_script(%q($('.nav-label:contains("Users")').click();))
  has_link?('Search', count: 4)
  click_link('Search')
  sleep 2
  fill_in 'search-input', with: 'VitalijStudentEdit'
  sleep 1
  click_button('Go!')
  sleep 3
  click_link 'Edit string'
  expect(Capybara.page).to have_text('Edit user profile')
  edit_user_by_admin
end

Then(/^Admin should see changes$/) do
  expect_user_changes_by_adm
  edit_user_by_admin_back
  do_logout
end