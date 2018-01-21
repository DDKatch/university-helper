require "rack"
require "rack/session/redis"
require "redis"
require "./lib/config"

require_relative "telegram_bot"

use Rack::Session::Redis

run TelegramBot.new
