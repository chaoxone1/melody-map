class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
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
