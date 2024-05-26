class MessagesController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :authenticate_user!

  def index
    @messages = Message.order(created_at: :asc).last(5)
  end

  def hide
    @message = Message.find(params[:id])
    @message.update(hidden: true)
    $redis.xadd "message-update", { request: { message_id: @message.id }.to_json }

    render turbo_stream:
      turbo_stream.update(@message,
        partial: 'messages/message',
        locals: { message: @message }
      )
  end

end