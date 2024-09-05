class User < ApplicationRecord
  # Include default devise modules.
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom validation
  validates :username, presence: true
  validates :categories, presence: true
  # Self-referential associations
  has_many :follows
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :events
  acts_as_favoritor
  has_many :bookmarks

  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  #Notifications
  # has_many :notifications, foreign_key: :recipient_id
  # has_many :active_notifications, -> { where(read_at: nil) }, class_name: 'Notification', foreign_key: :recipient_id
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

  def categories_list
    categories.present? ? categories.split(",") : []
  end

  def categories_list=(value)
    self.categories = value.reject(&:blank?).join(",")
  end

  def following?(other_user)
    return false if other_user.nil?
    following_relationships.exists?(following_id: other_user.id)
  end
end
