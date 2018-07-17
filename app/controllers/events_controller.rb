# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[edit update destroy]

  def index
    events = Event.all
    render :index, locals: { events: events, message: 'All events' }
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params.merge(user_id: current_user.id))
    if @event.save
      redirect_to list_events_path(start_time: time_format(@event))
    else
      render :new
    end
  end

  def update
    if @event.update(event_params.merge(start_time: @last_time))
      redirect_to list_events_path(start_time: time_format(@event))
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to list_events_path(start_time: time_format(@event))
  end

  def my
    my_events = Event.where(user: current_user)
    render :index, locals: { events: my_events, message: 'My events' }
  end

  def list
    @date = params[:start_time]
    @events = Event.where(start_time: @date)
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

  def find_event
    @event = Event.find(params[:id])
    @list_time = @event.start_time
  end

  def time_format(event)
    event.start_time.strftime('%d-%m-%Y')
  end
end
