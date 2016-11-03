require "./lib/bot_command/base"
require "./lib/bot_command/date_features"
require "./lib/bot_command/labs_features"

Dir["./lib/bot_command/*.rb"].each { |file| require file }

# module for bo commands
module BotCommand
end
