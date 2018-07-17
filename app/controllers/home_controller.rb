# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.count
    @my_events = Event.where(user: current_user).count
  end
end
