class NotifyEmail < NotifyChannel

  default "subject", Settings.notifier.email.default_subject

  def notify
    NotifierMailer.send_message(@service_info["recipient"], @service_info["subject"], @message).deliver
  end
end
