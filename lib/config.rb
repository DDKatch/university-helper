require 'logger'
require 'yaml'
require 'pry'

class Config
  class << self 
    attr_reader :database, :token, :logger

    def setup_token
      ENV['telegram_bot_token'] 
    end

    def setup_logger
      Logger.new STDOUT, Logger::DEBUG
    end

    def setup_database
      Redis.new(url: ENV["REDIS_URL"])
    end

    # def setup_i18n
    #   I18n.load_path = Dir['config/locales.yml']
    #   I18n.locale = :en
    #   I18n.backend.load_translations
    # end
  end

  # setup_i18n
  @database ||= self.setup_database
  @token ||= self.setup_token
  @logger ||= self.setup_logger
end
