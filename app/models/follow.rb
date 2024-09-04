class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  validates :follower, uniqueness: { scope: :following, message: 'User is already being followed' }

  after_create_commit :notify_user

  private

  def notify_user
    Notification.create(user: follower, recipient: following, notification_type: 'follow')
  end
end
