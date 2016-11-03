require "telegram/bot"

include Environment

module BotCommand
  # base command class
  class Base
    attr_reader :user, :message, :api

    def initialize(user, message)
      @user = user
      @message = message
      @api = ::Telegram::Bot::Api.new(Environment.token)
    end

    def should_start?
      raise NotImplementedError
    end

    def start
      raise NotImplementedError
    end

    protected

    def send_message(text, options = {})
      @api.send_message({ chat_id: user.id, text: text }.update(options))
    end

    def text
      msg = @message["message"]
      msg.nil? ? @message["callback_query"]["data"] : msg["text"]
    end
  end
end
