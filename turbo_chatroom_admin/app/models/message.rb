class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  delegate :username, to: :user
  delegate :name, to: :room, prefix: true

  def broadcast_message
    broadcast_append_later_to(
      'messages',
      target: 'messages',
      partial: 'messages/message',
      locals: {
        message: self
      }
    )
  end

end
