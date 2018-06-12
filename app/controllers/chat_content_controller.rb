class ChatContentController < ApplicationController
  def index
    @channels = Channel.all
  end

  def show
    @channel_id = params[:id]
    received = Received.where(channel_id: @channel_id)
    reply = Reply.where(channel_id: @channel_id)

    @channel_chat = received + reply
    @channel_chat.sort_by!{ |content| [content.created_at]}
  end
end
