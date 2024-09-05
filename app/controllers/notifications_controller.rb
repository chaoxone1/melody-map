class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @notifications = current_user.notifications.includes(event: :record).order(created_at: :desc)
      # Mark notifications as read (optional)
      current_user.notifications.where(read_at: nil).update_all(read_at: Time.current)
    end
  end
