require_relative "bot_command"
require_relative "user"

# aaa some comment
class BotMessageDispatcher
  attr_reader :message, :user
  AVAILABLE_COMMANDS = [
    BotCommand::Start,
    BotCommand::Semester,
    BotCommand::Subject,
    BotCommand::Submit,
    BotCommand::Status,
    BotCommand::Reset
  ].freeze

  def initialize(message, user)
    @message = message
    @user = user
  end

  def process
    if command = AVAILABLE_COMMANDS.find { |command_class| command_class.new(@user, @message).should_start? }
      command.new(@user, @message).start
    elsif @user.next_bot_command[:class]
      bot_command = @user.next_bot_command[:class]
      bot_command.new(@user, @message).public_send @user.next_bot_command[:method]
    else
      BotCommand::Undefined.new(@user, @message).start
    end && user.save
  end
end
