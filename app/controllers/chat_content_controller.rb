class ChatContentController < ApplicationController
  def index
    @channels = Channel.all
  end

  def show
  end
end
