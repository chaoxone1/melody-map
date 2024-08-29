class BookmarksController < ApplicationController

  def index
    all_favorite_events = current_user.all_favorites.map(&:favoritable).select { |e| e.is_a?(Event) }
    @upcoming_events = current_user.all_favorites.select do |event|
      event.favoritable.date >= Date.today
    end
    @past_events = current_user.all_favorites.select do |event|
      event.favoritable.date < Date.today
    end

    @geocoded_events = all_favorite_events.select(&:geocoded?)

    @markers = @geocoded_events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "events/info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "events/marker")
      }
    end
  end

  def create

  end

  def destroy

  end
end
