class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :favorite, :unfavorite]

  def index
    @events = Event.all
    @most_bookmarked = Event.all
    if params[:query].present?
      @events = Event.search_by_name_and_category(params[:query])
    elsif params[:category].present?
      if params[:category] == 'For You'
        preferred_categories = current_user.categories
        @events = @events.where(category: preferred_categories)
      else
        @events = @events.where(category: params[:category])
      end
    end

    case params[:view]
    when 'all'

    when 'today'
      @events = @events.where(date: Date.today.beginning_of_day..Date.today.end_of_day)
    when 'week'
      @events = @events.where(date: Date.today.beginning_of_week..Date.today.end_of_week)
    when 'for_you'
      preferred_categories = current_user.categories
      @events = @events.where(category: preferred_categories)
    else
      @events = @events.limit(6)
    end

    # Map loading for showing locations of Events
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    @top3_trendsetters = top3_trendsetters
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { event: @event }),
    }]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
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

  def my_events
    @events = current_user.events
  end

  def bookmark
    @event = Event.find(params[:id])
    current_user.bookmark(@event)
    redirect_to @event, notice: 'Event bookmarked successfully.'
  end

  def top3_trendsetters
    @trendsetters = User.left_joins(:follows)
    .group('users.id')
    .order('COUNT(follows.following_id) DESC')
    .limit(3)
  end

  def user_params
    params.require(:user).permit(:email, :address, :photo, :username, :radius, :password, :password_confirmation, :current_password, categories: [])
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location, :description, :category, :photo)

  end

  def set_event
    @event = Event.find(params[:id])
  end
end
