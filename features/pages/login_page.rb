require_relative '../../helpers/accounts_helper'
require_relative '../../helpers/email_helper'
require_relative '../pages/all_page'
require_relative '../pages/user_page'
# require_relative '../pages/advance'

require 'capybara'
require 'yaml'

# include AllPage
include UserPage
# include Advance

module LoginPage
  def do_login_as(user_type)
    creds = AccountsHelper.get_creds_by_type user_type
    visit '/en/auth/sign_in'
    do_login creds['login'], creds['password']
  end

  def do_login(email, password)
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end

  def do_incorrect_login(email, password)
    do_login email, password
    expect(Capybara.page).to have_text('Invalid email or password.')
  end

  def do_logout
    sleep 3
    find('.profile-role').click
    sleep 2
    expect(Capybara.page).to have_link('Sign Out')
    click_link('Sign Out')
  end

  def login_new(user)
    if user == 'student'
      change_lang
      fill_in 'user_email', with: $student_email
      fill_in 'user_password', with: 'testtest'
    elsif user == 'tutor'
      change_lang
      fill_in 'user_email', with: $tutor_email
      fill_in 'user_password', with: 'testtest'
    elsif user == 'invited student'
      change_lang
      fill_in 'user_email', with: $student_invitation_email
      fill_in 'user_password', with: 'testtest'
    end
    click_button 'Sign in'
    sleep 3
  end

  def confirm_creation(user)
    confirm_url = EmailHelper.new.get_confirmation_link
    visit confirm_url
    change_lang
    sleep 1
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Activate'
    have_info_message?('user_confirmation')
    # expect(Capybara.page).to have_selector('.profile-name')
    case user
      when user == 'new_student'
        expect(Capybara.page).to have_text($student_first_name)
      when user == 'new_tutor'
        expect(Capybara.page).to have_text($tutor_first_name)
      else
        puts "#{user} created"
    end
  end

  def confirm_invitation
    invitation_url = EmailHelper.new.get_invitation_link
    visit invitation_url
    sleep 2
    change_lang
    has_css?('#edit_user', count: 4)
    fill_in 'user_first_name', with: $student_invitation_first_name
    fill_in 'user_last_name', with: $student_invitation_last_name
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Submit'
    have_info_message?('user_invitation_confirmed')
    sleep 3
    do_logout
  end

  def change_lang
    if has_text?('Русский'||'Українська')
      execute_script(%q($('div.sign-in-locale').click();))
      click_link('English')
    end
  end
end
