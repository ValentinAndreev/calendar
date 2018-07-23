# frozen_string_literal: true

class RecurrentEventService
  def call(events, date)
    date = date.to_date
    daily_events(events, date) + weekly_events(events, date) + monthly_events(events, date) + annually_events(events, date)
  end

  def find_by_date(recurrents, date)
    recurrents.find_all { |f| f[:start_time] == date.to_s[0..9] }
  end


  private

  def daily_events(events, date)
    recurrent_events = []
    recurrent = find_events(events, 'daily', date.end_of_month)
    recurrent.each do |event|
      daily_start(event, date).upto(date.end_of_month) do |day|
        recurrent_events << event_params(event, 'daily', day) if event.start_time != day
      end
    end
    recurrent_events
  end

  def weekly_events(events, date)
    recurrent_events = []
    date = date.to_date
    recurrent = find_events(events, 'weekly', date.end_of_month)
    recurrent.each do |event|
      (weekly_start(event, date)..(date.end_of_month)).step(7).each do |day|
        recurrent_events << event_params(event, 'weekly', day) if event.start_time != day
      end
    end
    recurrent_events
  end

  def monthly_events(events, date)
    recurrent_events = []
    recurrent = find_events(events, 'monthly', date.end_of_month)
    recurrent.each do |event|
      recurrent_events << event_params(event, 'monthly', event.start_time.change(year: date.year, month: date.month)) if check_month(event, date)
    end
    recurrent_events
  end

  def annually_events(events, date)
    recurrent_events = []
    recurrent = find_events(events, 'annually', date.end_of_month)
    recurrent.each do |event|
      recurrent_events << event_params(event, 'annually', event.start_time.change(year: date.year)) if check_year(event, date)
    end
    recurrent_events
  end

  def find_events(events, period, date)
    events.where(recurrent: period).where('start_time < ?', date)
  end

  def daily_start(event, date)
    event.start_time < date.beginning_of_month ? date.beginning_of_month : event.start_time.to_date
  end

  def weekly_start(event, date)
    date.beginning_of_month + (event.start_time.wday - date.beginning_of_month.wday)
  end

  def check_month(event, date)
    event.start_time.month != date.month || event.start_time.year != date.year
  end

  def check_year(event, date)
    event.start_time.year != date.year && event.start_time.month == date.month
  end

  def event_params(event, period, day)
    { base_start: event.start_time, start_time: day.to_s[0..9], text: event.text, recurrent: period,
      username: "#{event.username} #{event.email}", name: event.name }
  end
end
