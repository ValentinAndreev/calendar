# frozen_string_literal: true

require 'rails_helper'

feature "User's actions to login/logout" do
  let(:user) { create(:user) }

  scenario 'login with right email and password' do
    log_in_user(user.email, user.password)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario "not registered user can't be logined" do
    log_in_user('wrong@email.com', 'wrong_password')
    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'wrong email error message' do
    log_in_user('wrong@email.com', user.password)
    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'wrong password error message' do
    log_in_user(user.username, 'wrong_password')
    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'logout' do
    log_in_user(user.email, user.password)
    click_on 'Logout'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'home page' do
    log_in_user(user.email, user.password)
    check_presence(['All events', 'Your events', 'Welcome'])
    check_links(['Home', 'Edit profile', 'Logout', 'All events', 'My events'])
  end
end
