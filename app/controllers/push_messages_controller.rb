class PushMessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
    text = params[:message]
    channel_id = params[:channel_id]
    Rails.logger.debug("push message : #{params[:message]}")
    Rails.logger.debug("  channel id : #{params[:channel_id]}")
    push_to_line(channel_id, text)

    Channel.all.each do |channel|
      Rails.logger.debug("===========================")
      Rails.logger.debug("channel    : #{channel.inspect}")
      Rails.logger.debug("channel id : #{channel.channel_id}")
      Rails.logger.debug("===========================")
      # push_to_line(channel.channel_id, text)
    end

    redirect_to '/push_messages/new'
  end

  # 傳送訊息到 line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?

    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    } 

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API 物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = '9f54965e7641954e2846ad65cee2dc5e'
      config.channel_token = 'G8PH13pEn3yMtr4Q4VKfSOcfeq1QPnKZqekzBUypbR0GptdH77LzAHn9ti0E8IKUgBuqBI7sIsBu53hZP2Qhq/V2sqvTpEND+9u5pPhTuX8Iq07ITgn7ZsoT9UGMbUNaHlzEedzTWrPLLzi/7V+QYgdB04t89/1O/w1cDnyilFU='
    }
  end
end