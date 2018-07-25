# frozen_string_literal: true

# Presenter for events
class EventsPresenter < BasePresenter
  def initialize(local_assigns)
    return unless local_assigns
    @date = local_assigns[:date]
    @recurrents = local_assigns[:recurrents]
  end

  def another_month(date)
    date if date.to_s[0..6] != @date.to_s[0..6]
  end

  def current_month(date, events)
    return unless !another_month(date) && events_day(events, date).zero?
    "#{date} <br/>"
  end

  def date_event(date, events)
    return unless another_month(date) != date && events_day(events, date).positive?
    "#{link_to date, routes.list_events_path(start_time: date)} <br/> Events: #{events.size + recurrent_date(@recurrents, date).size} <br/>"
  end

  def add_link(date)
    link_to 'Add', routes.new_event_path(start_time: date) unless another_month(date)
  end

  private

  def events_day(events, date)
    events.size + recurrent_date(@recurrents, date).size
  end
end
