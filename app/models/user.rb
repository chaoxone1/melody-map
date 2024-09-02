class User < ApplicationRecord
  # Include default devise modules.
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Self-referential associations
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follower'
  has_many :followers, through: :follower_relationships, source: :user
  has_many :events
  acts_as_favoritor
  has_many :bookmarks

  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follower'
  has_many :following, through: :following_relationships, source: :following

  def categories_list
    categories.present? ? categories.split(",") : []
  end

  def categories_list=(value)
    self.categories = value.reject(&:blank?).join(",")
  end
end
