# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    events = Event.all
    render :index, locals: { events: events, message: 'All events' }
  end

  def show
    @event = Event.find(params[:id])
  end

  def my
    my_events = Event.where(user: current_user)
    render :index, locals: { events: my_events, message: 'My events' }
  end
end
