module BotCommand
  # reset command
  class Reset < Base
    def should_start?
      text =~ /\A\/reset/
    end

    def start
      send_message("Отчислен")
      user.clean_all_data
      user.reset_next_bot_command
    end
  end
end
