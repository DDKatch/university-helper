module BotCommand
  # command status
  class Status < Base
    include DateFeatures

    def should_start?
      text =~ /\A\/status/
    end

    def start
      send_message("К этому времени у тебя должно было быть сдано:\n" + labs_status)
      user.reset_next_bot_command
    end

    def labs_status
      user.subjects.each.inject("") do |status, data|
        status << "#{subject(data)} - #{labs(data)}\n"
      end
    end

    def subject(data)
      data[0]
    end

    def labs(data)
      (1..data.count).to_a.join(" ")
    end

    def accepted_labs(labs_amount)
      "#{(labs_amount * days_ratio).to_i} из #{labs_amount}"
    end

    def days_ratio
      (Date.today - user.semester[:start]) / time_left.to_f
    end
  end
end
