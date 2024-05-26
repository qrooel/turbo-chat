class TestController < ApplicationController

  def index
    # while true
    #   messages_stream = $redis.xread("messages", 0, block: 10000)
    #
    #   (messages_stream["messages"] || []).each do |message_entry|
    #     redis_entry_id = message_entry.first
    #     message_attributes = JSON.parse(message_entry.last["request"])
    #
    #     Message.find(message_attributes['message_id']).broadcast_message
    #
    #     $redis.xdel('messages', redis_entry_id)
    #   end
    # end

    render json: {}
  end

end