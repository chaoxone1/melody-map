class FollowersController < ApplicationController

  def follow
    @user = User.find(params[:id])
    # Logic for following the creator, e.g., adding the creator to the user's followed creators
    current_user.follow(@user)
    redirect_to event_path(@user.events.first), notice: 'User followed successfully.'
  end

  def create

  end

  def delete

  end

  def index

  end
end
