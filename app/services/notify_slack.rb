require 'slack-notifier'
class NotifySlack < NotifyChannel

  default "username", Settings.notifier.slack.default_username
  
  def setup
    @notifier = Slack::Notifier.new @service_info["webhook_url"], channel: @service_info["channel"],
                                                    username: @service_info["username"]
  end

  def notify
    response = @notifier.ping @message
    raise "[Slack] Unable to notify, reason: #{response}" if response.code != "200"
  end
end
