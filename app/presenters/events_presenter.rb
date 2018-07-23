# Presenter for events
class EventsPresenter < BasePresenter
  def initialize(local_assigns)
    if local_assigns
      @date = local_assigns[:date]
      @recurrents = local_assigns[:recurrents]
    end
  end

  def another_month(date)
    date if date.to_s[0..6] != @date.to_s[0..6]
  end

  def current_month(date, events)
    "#{date} <br/>" if !another_month(date) && events.size + recurrent_date(@recurrents, date).size == 0
  end

  def event_count(date, events)
    if another_month(date) != date && events.size + recurrent_date(@recurrents, date).size > 0
      "<br/> Events: #{events.size + recurrent_date(@recurrents, date).size} <br/>"
    end
  end

  def date_link(date, events)
    if another_month(date) != date && events.size + recurrent_date(@recurrents, date).size > 0
      link_to date, routes.list_events_path(start_time: date)
    end
  end

  def add_link(date)
    link_to 'Add', routes.new_event_path(start_time: date) unless another_month(date)
  end
end
