class TestController < ApplicationController

  def index
    message = Message.create!(user: User.first, room: Room.first, body: "NEW!")
    message.broadcast_append

    render json: {}
  end

end