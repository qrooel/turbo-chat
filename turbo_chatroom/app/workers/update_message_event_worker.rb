require 'sidekiq-scheduler'

class UpdateMessageEventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'message'

  def perform
    messages_stream = $redis.xread("message-update", 0, block: 2000, count: 100)

    (messages_stream["message-update"] || []).each do |message_entry|
      redis_entry_id = message_entry.first
      message_attributes = JSON.parse(message_entry.last["request"])
      message = Message.find(message_attributes['message_id'])

      message.broadcast_remove_to(message.room, target: message)
      message.broadcast_remove_to('public_messages', target: message)
      $redis.xdel('message-update', redis_entry_id)
    end
  end

end