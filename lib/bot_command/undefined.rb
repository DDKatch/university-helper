module BotCommand
  # undefined command
  class Undefined < Base
    def start
      send_message("Unknown command. Type /start if you are a new user or you have finished the game, else type the appropriate command.")
    end
  end
end
