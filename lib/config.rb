require 'logger'
require 'yaml'

class Config
  class << self 
    attr_reader :database, :token, :logger

    def setup_token
      YAML.load(IO.read 'config/secrets.yml')['telegram_bot_token']
    end

    def setup_logger
      Logger.new STDOUT, Logger::DEBUG
    end

    def setup_database
      Redis.new(url: ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379")
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
