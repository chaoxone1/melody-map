class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "notifications_#{current_user.id}_channel"
    stream_for current_user
  end

  def unsubscribed
    stop_all_streams
  end
end
