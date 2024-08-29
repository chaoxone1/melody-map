class Event < ApplicationRecord
  belongs_to :user
  attr_accessor :title, :description, :date, :location

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  has_one_attached :photo
  acts_as_favoritable

  include PgSearch::Model
pg_search_scope :search_by_name_and_category,
  against: [ :name, :category ],
  using: {
    tsearch: { prefix: true }
  }
end
