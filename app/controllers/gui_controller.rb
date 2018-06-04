require 'line/bot'
class GuiController < ApplicationController
  protect_from_forgery with: :null_session

  def eat
    render plain: "吃土啦"
  end

  def request_headers
    render plain: request.headers.to_h.reject{ |key, value|
      key.include? '.'
    }.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def response_headers
    response.headers['5566'] = 'QQ'
    render plain: response.headers.to_h.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def request_body
    render plain: request.body
  end

  def show_response_body
    puts "===這是設定前的response.body:#{response.body}==="
    render plain: "虎哇花哈哈哈"
    puts "===這是設定後的response.body:#{response.body}==="
  end

  def sent_request
    # uri = URI('http://localhost:3000/gui/response_body')
    # response = Net::HTTP.get(uri)
    # render plain: response

    # uri = URI('http://localhost:3000/gui/response_body')
    # response = Net::HTTP.get(uri).force_encoding("UTF-8")
    # render plain: translate_to_korean(response)

    uri = URI('http://localhost:3000/gui/eat')
    http = Net::HTTP.new(uri.host, uri.port)
    http_request = Net::HTTP::Get.new(uri)
    http_response = http.request(http_request)

    render plain: JSON.pretty_generate({
      request_class: request.class,
      response_class: response.class,
      http_request_class: http_request.class,
      http_response_class: http_response.class
    })
  end

  def translate_to_korean(message)
    "#{message}油~"
  end

  def webhook
    # Line Bot API 物件初始化
    client = Line::Bot::Client.new { |config|
      config.channel_secret = '9f54965e7641954e2846ad65cee2dc5e'
      config.channel_token = 'G8PH13pEn3yMtr4Q4VKfSOcfeq1QPnKZqekzBUypbR0GptdH77LzAHn9ti0E8IKUgBuqBI7sIsBu53hZP2Qhq/V2sqvTpEND+9u5pPhTuX8Iq07ITgn7ZsoT9UGMbUNaHlzEedzTWrPLLzi/7V+QYgdB04t89/1O/w1cDnyilFU='
    }

    # 取得 reply token
    reply_token = params['events'][0]['replyToken']

    # 設定回覆訊息
    message = {
      type: 'text',
      text: '媛媛加油~~愛妳愛妳~~'
    }

    # 傳送訊息
    response = client.reply_message(reply_token, message)

    # 回應 200
    head :ok
  end

end
