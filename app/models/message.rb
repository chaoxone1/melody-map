class Message < ApplicationRecord
  after_create_commit :broadcast_message
  belongs_to :user
  belongs_to :event

  private

  def broadcast_message
    broadcast_append_to "event_#{event.id}_messages",
                        partial: "messages/message",
                        locals: { message: self, user: user },
                        target: "messages"
  end
end
