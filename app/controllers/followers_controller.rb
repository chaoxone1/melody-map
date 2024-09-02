class FollowersController < ApplicationController

  def create
    @user = User.find(params[:id])
    # Logic for following the creator, e.g., adding the creator to the user's followed creators
    Follow.create(user_id:current_user.id, following_id:@user.id)
    redirect_to event_path(@user.events.first), notice: 'User followed successfully.'
  end

  def destroy
    @user = User.find(params[:id])
    # Logic for following the creator, e.g., adding the creator to the user's followed creators
    Follow.find_by(user_id:current_user.id, following_id:@user.id).destroy
    redirect_to event_path(@user.events.first), notice: 'User unfollowed successfully.'
  end

  def index
  end
end
