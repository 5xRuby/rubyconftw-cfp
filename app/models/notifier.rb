class Notifier < ApplicationRecord
  belongs_to :activity

  validates :service_name, presence: true
  validate :validate_service_info

  VALID_SERVICE_NAMES = %w(slack email)

  REQUIRED_SERVICE_INFO = %w(webhook_url channel recipient)
  SERVICE_INFO_HINT = {
    "webhook_url" => "Slack Web Hook URL",
    "channel" => "Should be some_channel or @someon",
    "username" => "Bot name for slack. Left blank for default value: #{Settings.notifier.slack.default_username}",
    "recipient" => "Recipient address",
    "subject" => "Mail subject. Left blank for default value: #{Settings.notifier.email.default_subject}",
  }

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

  def service_info_errors
    @service_info_errors ||= {}
  end

  private

  def validate_service_info
    has_error = false
    fields_to_check = []
    case service_name
    when "email"
      fields_to_check = ["recipient"]
    when "slack"
      fields_to_check = ["webhook_url", "channel"]
    else
      has_error = true
    end
    fields_to_check.each do |check_key|
      check = check_service_info_present?(check_key)
      has_error = true if check
    end
    errors["service_info"] = true if has_error
  end

  def check_service_info_present?(key)
    if service_info[key].blank?
      service_info_errors[key] = I18n.translate("errors.messages.blank")
      return true
    end
    return false
  end
end
