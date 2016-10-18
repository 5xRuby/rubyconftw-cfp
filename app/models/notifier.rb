class Notifier < ApplicationRecord
  belongs_to :activity

  VALID_SERVICE_NAMES = %w(slack email)

  def get_channel_class
    case self.service_name
    when "slack"
      NotifySlack
    when "email"
      NotifyEmail
    else
      logger.error "Unknown service channel: #{self.service_name}"
      NotifyChannel
    end
  end
  
  def handle_event(event, subject)
    if self.try("on_#{event}")
      get_channel_class.perform_later(self.service_info, event, subject)
    end
  end

end
