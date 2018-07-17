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

  def list
    @events = Event.where(id: params[:events])
    @date = @events.first.start_time.strftime('%d-%m-%Y')
  end

  def date
    if params[:events_type] == 'All events'
      redirect_to events_path(start_date: form_date(params[:date]))
    else
      redirect_to my_events_path(start_date: form_date(params[:date]))
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :date, :user_id, :text, :events, :events_type, :start_date)
  end

  def form_date(date)
    date['year'] + '-' + date['month'] + '-' + date['day']
  end
end
