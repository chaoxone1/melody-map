class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def trendsetters_index
    @trendsetters = User.all
  end

  def trendsetters_show
    # 1. List of top 10 users with the most follows
    @trendsetter = User.find(params[:id])

    @upcoming_events = @trendsetter.events.select do |event|
      event.date >= Date.today
    end
    @past_events = @trendsetter.events.select do |event|
      event.date < Date.today
    end
  end

  def myspaces
    @followers = current_user.followers
    @following = current_user.following
    @bookmarks = current_user.bookmarks
    @events = current_user.events
  end

  def abouts_us
  end

  def created_events
    @events = current_user.events
  end

  def mybookmarkcount
    @bookmarks = current_user.bookmarks.count
  end
end
