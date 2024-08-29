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
    @trendsetter = User.find(params[:id])

  end

  def myspaces
    @followers = current_user.followers
    @following = current_user.following
    @bookmarks = current_user.bookmarks
    @events = current_user.events

  end

end
