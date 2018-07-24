# frozen_string_literal: true

# Presenter for recurrent event
class RecurrentPresenter < BasePresenter
  def initialize(local_assigns)
    @recurrents = recurrent_date(local_assigns[:recurrents], local_assigns[:date]) if local_assigns
  end

  def event_creator(event)
    "Creator: #{event[:username]} <br/>"
  end

  def event_name(event)
    "Event name: #{event[:name]} <br/>"
  end

  def periodicity(event)
    "Periodicity of the event: #{event[:recurrent]} <br/>"
  end

  def text(event)
    "Event text: #{event[:text]} <br/>"
  end

  def recurrent_title
    "<h5 align='center'>Recurrent events</h5>" unless @recurrents.empty?
  end

  def base_start(recurrent)
    "Base start: #{recurrent[:base_start]}"
  end

  def event_link(recurrent)
    link_to 'Event', routes.list_events_path(start_time: recurrent[:base_start])
  end
end
