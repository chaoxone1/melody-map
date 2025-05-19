class BookmarksController < ApplicationController
  def index
    @upcoming_events = upcoming_favorites
    @past_events = past_favorites
    @geocoded_events = geocoded_favorite_events

    @markers = generate_markers(@geocoded_events)
  end

  def create
  end

  def destroy
  end

  private

  def all_favorite_events
    current_user.all_favorites.map(&:favoritable).select { |e| e.is_a?(Event) }
  end

  def upcoming_favorites
    current_user.all_favorites.select { |event| event.favoritable.date >= Date.today }
  end

  def past_favorites
    current_user.all_favorites.select { |event| event.favoritable.date < Date.today }
  end

  def geocoded_favorite_events
    all_favorite_events.select(&:geocoded?)
  end

  def generate_markers(events)
    events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "events/info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "events/marker")
      }
    end
  end
end
