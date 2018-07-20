# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[edit update destroy]

  def index
    render_events(Event.all, 'All events')
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params.merge(user_id: current_user.id))
    if @event.save
      redirect_to list_events_path(start_time: @event.start_time)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params.merge(start_time: @last_time))
      redirect_to list_events_path(start_time: @event.start_time)
    else
      render :edit
    end
  end

  def destroy
    start_time = @event.start_time
    @event.destroy
    if Event.where(start_time: start_time).count.positive?
      redirect_to list_events_path(start_time: start_time)
    else
      redirect_to events_path(start_date: start_time)
    end
  end

  def my
    render_events(Event.where(user: current_user), 'My events')
  end

  def list
    date = params[:start_time]
    render_list(date, Event.where(start_time: date), "All events: #{date}")
  end

  def my_list
    date = params[:start_time]
    render_list(date, Event.where(start_time: date, user_id: current_user.id), "My events: #{date}")
  end

  def date
    date = FormDate.new.call(params[:start_date])
    if params[:events_type] == 'All events'
      redirect_to events_path(start_date: date)
    else
      redirect_to my_events_path(start_date: date)
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :user_id, :text, :events, :events_type, :start_date, :recurrent)
  end

  def find_event
    @event = Event.find(params[:id])
    @list_time = @event.start_time
  end

  def render_events(events, message)
    date = FormDate.new.call(params[:start_date])
    recurrent = RecurrentEventService.new.call(events, date)
    render :index, locals: { events: events, recurrent: recurrent, message: message, start_date: date }
  end

  def render_list(date, events, message)
    recurrent = RecurrentEventService.new.find_by_date(events, date[0..9])
    render :list, locals: { events: events, recurrent: recurrent, message: message, date: date }
  end
end
