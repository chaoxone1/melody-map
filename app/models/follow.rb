class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  validates :follower, uniqueness: { scope: :following, message: 'User is already being followed' }

  after_create_commit :notify_user

  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  private

  def notify_user
    FollowNotifier.with(record: self, recipient: following, message: "New post").deliver(following)
  end
end
