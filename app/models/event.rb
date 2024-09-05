class Event < ApplicationRecord
  belongs_to :user
  has_many :messages

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  has_one_attached :photo
  acts_as_favoritable

  # Custome Validatation
  validates :photo, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, presence: true
  validates :date, presence: true
  validates :category, presence: true

  include PgSearch::Model
pg_search_scope :search_by_name_and_category,
  against: [ :name, :category ],
  using: {
    tsearch: { prefix: true }
  }
end
