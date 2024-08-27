class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    if params[:query].present?
      @events = Event.search_by_name_and_category(params[:query])
    else
      @events = Event.all
    end

    # Map loading for showing locations of Events
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
      }
    end
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
    @event = Event.find(params[:id])
    @event.destroy
  end

  def my_events

  end

  private
  def set_events
    @event = Event.find(params[:id])
  end
end
