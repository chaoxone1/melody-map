class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def trendsetters_index
    @top_users = User.joins(:followers)
    .group('users.id')
    .order('COUNT(followers.id) DESC')
    .limit(10)
  end

  def trendsetters_show
    # 1. List of top 10 users with the most follows
    @top_users = User.joins(:followers)
                     .group('users.id')
                     .order('COUNT(followers.id) DESC')
                     .limit(10)

    # For each top user, also get the number of followers, upcoming events, and past events
    @users_data = @top_users.map do |user|
      {
        user: user,
        followers_count: user.followers.count,
        upcoming_events: user.events.where('date >= ?', Date.today).order(date: :asc),
        past_events: user.events.where('date < ?', Date.today).order(date: :desc)
      }
    end
  end

  def trendsetters_show

  end

  def myspaces
    @followers = current_user.followers
    @following = current_user.following
    @bookmarks = current_user.bookmarks
    @events = current_user.events

  end

end
