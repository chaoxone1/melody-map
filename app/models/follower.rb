class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :following, class_name: "User"
end
