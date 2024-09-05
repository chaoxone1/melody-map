class FollowersController < ApplicationController

  def create
    @user = User.find(params[:id])
    # Logic for following the creator, e.g., adding the creator to the user's followed creators
    Follow.create(user_id:current_user.id, following_id:@user.id)
    respond_to do |format|
      format.turbo_stream  do
        render turbo_stream: turbo_stream.update(:follow_btn, partial: "follow",
        locals: { user: @user })
      end
      format.html { redirect_to events_path, notice: 'User followed successfully.' }
    end
  end

  def destroy
    @user = User.find(params[:id])
    # Logic for following the creator, e.g., adding the creator to the user's followed creators
    Follow.find_by(user_id:current_user.id, following_id:@user.id).destroy
    respond_to do |format|
      format.turbo_stream  do
        render turbo_stream: turbo_stream.update(:follow_btn, partial: "follow",
        locals: { user: @user })
      end
      format.html { redirect_to events_path, notice: 'User followed successfully.' }
    end
  end

  def index
    @followers = current_user.followers
    @following = current_user.following
  end
end
