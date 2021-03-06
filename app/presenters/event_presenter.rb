# frozen_string_literal: true

# Presenter for event
class EventPresenter < BasePresenter
  def initialize(local_assigns); end

  def event_creator(event)
    "Creator: #{event.username} #{event.email} <br/>"
  end

  def event_name(event)
    "Event name: #{event.name} <br/>"
  end

  def periodicity(event)
    "Periodicity of the event: #{event.recurrent} <br/>"
  end

  def text(event)
    "Event text: #{event.text} <br/>"
  end

  def edit_links(event, user)
    return unless user.id == event.user_id
    "#{link_to 'Edit event', routes.edit_event_path(event)} " \
    "#{link_to 'Delete event', routes.event_path(event), method: :delete, data: { confirm: 'Are you sure?' }}"
  end
end
