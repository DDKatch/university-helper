module BotCommand
  # semester command
  class Semester < Base
    include DateFeatures

    def should_start?
      text =~ /\A\/semester/
    end

    def start
      send_message("Когда начинаем учиться?")
      user.next_bot_command.update(class: self.class, method: :start_date)
    end

    def start_date
      valid_date? do |date|
        user.semester[:start] = date
        send_message("Когда дедлайн по лабам?")
        user.next_bot_command.update(class: self.class, method: :finish_date)
      end
    end

    def finish_date
      valid_date? do |date|
        user.semester[:finish] = date
        send_message("Понял, дней до дедлайна #{time_left}!")
        user.reset_next_bot_command
      end
    end
  end
end
