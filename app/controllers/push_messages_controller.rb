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

    if text == '下麵'
      upload_to_imgur
      sent_image_to_line(channel_id, upload_to_imgur)
    else
      sent_message_to_line(channel_id, text)
      Channel.all.each do |channel|
        Rails.logger.debug("===========================")
        Rails.logger.debug("channel    : #{channel.inspect}")
        Rails.logger.debug("channel id : #{channel.channel_id}")
        Rails.logger.debug("===========================")
      end
    end

    redirect_to '/push_messages/new'
  end

  def upload_to_imgur
    image_url = 'http://s2.cdn.xiachufang.com/957cfeb8b1ca11e59368893cac04a188.jpg?imageView2/2/w/620/interlace/1/q/90'
    url = URI("https://api.imgur.com/3/image")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["authorization"] = 'Client-ID 7bf5a76e5d04727'

    request.set_form_data({"image" => image_url})
    response = http.request(request)
    json = JSON.parse(response.read_body)
    begin
      json['data']['link'].gsub("http:","https:")
    rescue
      nil
    end
  end

  # 傳送圖片到 line
  def sent_image_to_line(channel_id, reply_image)
    return nil if channel_id.nil? or reply_image.nil?

    # 設定回覆訊息
    message = {
      type: "image",
      originalContentUrl: reply_image,
      previewImageUrl: reply_image
    }

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # 傳送訊息到 line
  def sent_message_to_line(channel_id, text)
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