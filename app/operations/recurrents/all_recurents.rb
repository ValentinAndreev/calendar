# frozen_string_literal: true

module Recurrents
  class AllRecurents < Trailblazer::Operation
    step :daily
    step :weekly
    step :monthly
    step :annually

    def daily(options, events:, date:, **)
      options['recurrents'] = []
      recurrent = find_events(events, 'daily', date.end_of_month)
      recurrent.each do |event|
        daily_start(event, date).upto(date.end_of_month) do |day|
          options['recurrents'] << event_params(event, 'daily', day) if event.start_time != day
        end
      end
    end

    def weekly(options, events:, date:, **)
      recurrent = find_events(events, 'weekly', date.end_of_month)
      recurrent.each do |event|
        current_date = weekly_start(event, date)
        end_date = date.end_of_month + 1
        while current_date < end_date
          options['recurrents'] << event_params(event, 'weekly', current_date) unless weekly_event_day(event, current_date)
          current_date += 7.day
        end
      end
    end

    def monthly(options, events:, date:, **)
      recurrent = find_events(events, 'monthly', date.end_of_month)
      recurrent.each do |event|
        if check_month(event, date)
          options['recurrents'] << event_params(event, 'monthly', event.start_time.change(year: date.year, month: date.month))
        end
      end
    end

    def annually(options, events:, date:, **)
      recurrent = find_events(events, 'annually', date.end_of_month)
      recurrent.each do |event|
        options['recurrents'] << event_params(event, 'annually', event.start_time.change(year: date.year)) if check_year(event, date)
      end
    end

    private

    def find_events(events, period, date)
      events.where(recurrent: period).where('start_time < ?', date)
    end

    def daily_start(event, date)
      event.start_time < date.beginning_of_month ? date.beginning_of_month : event.start_time.to_date
    end

    def weekly_start(event, date)
      start = event.start_time
      start.to_s[0..9] == date.to_s[0..9] ? start + (start.wday - date.beginning_of_month.wday) : weekly_another_month(event, date)
    end

    def weekly_another_month(event, date)
      date.beginning_of_month + (event.start_time.wday - date.beginning_of_month.wday)
    end

    def weekly_event_day(event, current_date)
      event.start_time.to_s[0..9] == current_date.to_s[0..9] || event.start_time > current_date
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
end
