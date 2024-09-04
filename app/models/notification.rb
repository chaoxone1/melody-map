class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  after_create_commit { broadcast_notification }

  private

  def broadcast_notification
    NotificationBroadcastJob.perform_later(self)
  end
end
