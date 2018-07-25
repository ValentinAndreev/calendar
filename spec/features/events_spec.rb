# frozen_string_literal: true

require 'rails_helper'

feature 'Events actions' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :another_user) }
  let!(:event) { create(:event, user: user) }
  let!(:another_user_event) { create(:event, user: another_user) }
  let!(:daily_event) { create(:event, :daily, user: user) }
  let!(:weekly_event) { create(:event, :weekly, user: user) }
  let!(:monthly_event) { create(:event, :monthly, user: user) }
  let!(:annually_event) { create(:event, :annually, user: user) }
  let!(:another_daily_event) { create(:event, :daily, user: another_user) }
  before do
    log_in_user(user.email, user.password)
    click_on 'All events'
  end

  scenario 'month calendar' do
    check_presence(['All events:', 'Events: 7', 'Events: 3', 'Events: 2'])
    check_links(['Previous', 'Next', 'Logout', 'All events', 'My events', 'Add'])
  end

  scenario 'create event' do
    click_link('Add', match: :first)
    select('daily', from: 'event[recurrent]').select_option
    fill_in 'event[name]', with: 'New event name'
    fill_in 'event[text]', with: 'New event text'
    click_on 'Submit'
    click_on 'All events'
    check_presence(['Events: 8', 'Events: 4', 'Events: 3'])
  end

  scenario 'list first day events(day have no recurrent events)' do
    click_on Date.today.change(day: 1).to_s[0..9].to_s
    expect(page).to_not have_content('Recurrent events')
    check_presence(["All events: #{Date.today.change(day: 1).to_s[0..9]}", 'Creator:', 'Event name:', 'Periodicity of the event:', 'Event text'])
    check_links(['To calendar', 'Add event', 'Logout', 'All events(day)', 'My events(day)', 'Edit event', 'Delete event'])
  end

  scenario 'list second day events(with recurrent events)' do
    click_on Date.today.change(day: 2).to_s[0..9].to_s
    expect(page).to have_content('Recurrent events')
    expect(page).to have_link('Event')
  end

  scenario 'Only my month events' do
    click_on 'My events'
    check_presence(['Events: 5', 'Events: 2', 'Events: 1'])
  end

  scenario 'Only my day events' do
    click_on Date.today.change(day: 1).to_s[0..9].to_s
    click_on 'My events(day)'
    expect(page).to have_content("My events: #{Date.today.change(day: 1).to_s[0..9]}")
    expect(page).to have_content("Creator: #{user.username}")
    expect(page).to_not have_content("Creator: #{another_user.username}")
  end

  scenario 'Select date' do
    year = Date.today.change(year: Date.today.year + 1).year
    month = Date.today.change(month: 1).strftime('%B')
    select(year, from: 'start_date[year]').select_option
    select(month, from: 'start_date[month]').select_option
    select(Date.today.change(day: 1).day, from: 'start_date[day]').select_option
    click_on 'Move to date/reorder'
    expect(page).to have_content("#{month} #{year}")
  end
end
