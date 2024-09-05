# To deliver this notification:
#
# FollowNotifier.with(record: @post, message: "New post").deliver(User.all)

class FollowNotifier < ApplicationNotifier
  after_create_commit :broadcast_notification_count
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
  #
  deliver_by :action_cable do |config|
    config.channel = "NotificationsChannel"
    config.stream = ->{ recipient }
    config.message = ->{ params.merge(user_id: recipient.id) }
  end

  def broadcast_notification_count
    recipient = params[:recipient]  # Pass the recipient when triggering the notification
    # unread_count = recipient.notifications.unread.count
    p recipient
    broadcast_update_to "notification_#{recipient.id}",
                        target: "notification_count",
                        partial: "shared/notification",
                        locals: { user: recipient }
  end
end
