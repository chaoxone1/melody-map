class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications_#{notification.recipient_id}_channel", {
      message: render_notification(notification),
      unread_count: notification.recipient.notifications.unread.count
    }
  end

  private

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end
