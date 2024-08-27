class Event < ApplicationRecord
  belongs_to :user
  attr_accessor :title, :description, :date, :location
end
