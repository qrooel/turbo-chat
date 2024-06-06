require 'sidekiq-scheduler'

class ReceiveMessagesEventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'messages'

  def perform
    messages_stream = $redis.xread("messages", 0, block: 2000, count: 100)

    (messages_stream["messages"] || []).each do |message_entry|
      redis_entry_id = message_entry.first
      message_attributes = JSON.parse(message_entry.last["request"])

      message = Message.create!(
        id: message_attributes['message_id'],
        body: message_attributes['body'],
        user_id: message_attributes['user_id']
      )

      if message.broadcast_message
        $redis.xdel('messages', redis_entry_id)
      end
    end
  end

end