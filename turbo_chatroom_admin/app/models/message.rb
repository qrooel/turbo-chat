class Message < ApplicationRecord
  belongs_to :user, optional: true

  # has_many_attached :attachments

  # delegate :username, to: :user
  # delegate :name, to: :room, prefix: true

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
