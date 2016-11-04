module BotCommand
  # command subject
  class Subject < Base
    include LabsFeatures

    def should_start?
      text =~ /\A\/subject/
    end

    def start
      send_message("Какой предмет учим?")
      user.next_bot_command.update(class: self.class, method: :add_subject)
    end

    def add_subject
      send_message("Сколько лаб надо сдать?")
      user.next_bot_command.update(class: self.class, method: :add_labs, data: { subject: text })
      user.subjects.update(text => [] | old_labs)
    end

    def add_labs
      valid_labs? do |labs|
        send_message("ОК")
        user.subjects.update(subject_name => labs)
        user.reset_next_bot_command
      end
    end

    def subject_name
      user.next_bot_command[:data][:subject]
    end
  end
end
