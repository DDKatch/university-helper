require "rack"
require "rack/session/redis"
require "redis"

require_relative "telegram_bot"
require_relative "lib/config"

use Rack::Session::Redis

run TelegramBot.new
