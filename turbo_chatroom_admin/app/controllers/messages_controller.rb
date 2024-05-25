class MessagesController < ApplicationController

  def index
    @messages = Message.order(created_at: :asc).last(10)
  end

end