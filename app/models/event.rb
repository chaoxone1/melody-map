class Event < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :follows, class_name: 'EventFollow'
  has_many :followers, through: :follows, source: :user
end
