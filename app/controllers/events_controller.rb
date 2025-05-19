class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_event, only: %i[show edit update destroy favorite unfavorite]

  def index
    @events = EventsFetcher.new(params, current_user).fetch
    @most_bookmarked = Event.where('date >= ?', Date.today.beginning_of_day)
    @markers = MarkersHelper.generate(@events)
    @top3_trendsetters = top3_trendsetters
  end

  def show
    @markers = MarkersHelper.generate([@event])
    @message = Message.new(user: current_user)
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

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
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
    @events = @events.search_by_name_and_category(params[:query]) if params[:query].present?
  end

  def bookmark
    current_user.bookmark(@event)
    redirect_to @event, notice: 'Event bookmarked successfully.'
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location, :description, :category, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def top3_trendsetters
    User.left_joins(:follows)
        .group('users.id')
        .order('COUNT(follows.following_id) DESC')
        .limit(4)
  end
end
