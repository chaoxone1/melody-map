class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show

  end

  def create
    @event = Event.new
    @event.save
  end

  def update

  end

  def destroy

  end

  def my_events

  end
end
