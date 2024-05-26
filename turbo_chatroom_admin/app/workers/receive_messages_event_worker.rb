require 'sidekiq-scheduler'

class ReceiveMessagesEventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'messages'

  def perform
    messages_stream = $redis.xread("messages", 0, block: 2000, count: 100)

    (messages_stream["messages"] || []).each do |message_entry|
      redis_entry_id = message_entry.first
      message_attributes = JSON.parse(message_entry.last["request"])

      if Message.find(message_attributes['message_id']).broadcast_message
        $redis.xdel('messages', redis_entry_id)
      end
    end
  end

end