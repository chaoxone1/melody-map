class BookmarksController < ApplicationController

  def index
    @upcoming_events = current_user.all_favorites.select do |event|
      event.favoritable.date >= Date.today
    end
    @past_events = current_user.all_favorites.select do |event|
      event.favoritable.date < Date.today
    end
  end

  def create

  end

  def destroy

  end
end
