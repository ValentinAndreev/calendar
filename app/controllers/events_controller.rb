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
    if @event.update(event_params)
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
    render_recurrent(Event.all, 'All events')
  end

  def my_list
    render_recurrent(Event.where(user: current_user), 'My events')
  end

  def date
    date = FormattingDate.call(start_date: params[:start_date])['date'].to_s
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
  end

  def render_events(events, message)
    date = FormattingDate.call(start_date: params[:start_date])['date']
    render :index, locals: { recurrents: recurrents(events, date),
                             message: "#{message}: #{date.strftime('%B')}",
                             date: date.to_s, events: events }
  end

  def render_recurrent(events, message)
    date = params[:start_time]
    render :list, locals: { recurrents: recurrents(events, date),
                            message: "#{message}: #{date[0..9]}",
                            date: date[0..9], events: events.where(start_time: date) }
  end

  def recurrents(events, date)
    @recurrents ||= Recurrents::AllRecurents.call(events: events, date: date.to_date)['recurrents']
  end
end
