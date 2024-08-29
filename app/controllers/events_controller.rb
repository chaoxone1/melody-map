class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_events, only: [ :favorite, :unfavorite ]
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
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {event: event}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def favorite
    current_user.favorite(@event)
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event was successfully added to your favorites.' }
      format.json { render json: { success: true }, status: :ok }
    end
  end

  def unfavorite
    current_user.unfavorite(@event)
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event was successfully removed from your favorites.' }
      format.json { render json: { success: true }, status: :ok }
    end
  end

  def edit
    @event = Event.find(params[:id])
  end
  def show
    @event = Event.find(params[:id])

    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
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
    @events = current_user.events
  end

  def bookmark
    @event = Event.find(params[:id])
    # Logic for bookmarking the event, e.g., adding it to the user's bookmarked events
    current_user.bookmark(@event)
    redirect_to @event, notice: 'Event bookmarked successfully.'
  end

  private

  def set_events
    @event = Event.find(params[:id])
  end

  def events_params
    params.require(:event).permit(:title, :description, :date, :photo)
  end
end
