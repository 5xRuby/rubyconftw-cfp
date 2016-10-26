require 'slack-notifier'
class NotifySlack < NotifyChannel

  default "username", Settings.notifier.slack.default_username

  def setup
    @notifier = Slack::Notifier.new @service_info["webhook_url"], channel: @service_info["channel"],
      username: @service_info["username"]
  end

  def notify
    @attachment ||= {}
    response = @notifier.ping @message, attachments: [@attachment]
    raise "[Slack] Unable to notify, reason: #{response}" if response.code != "200"
  end

  def attach_author_info!(origin, user)
    origin.merge!({
      author_name: "#{user.name}",
      author_link: "#{user.github_url}",
      author_icon: "http:#{user.full_avatar_url(full_hostname)}",
    })
  end

  def attach_activity_info!(origin, activity)
    origin.merge!({
      footer: activity.name,
      footer_icon: activity.full_logo_url(full_hostname), 
    })
  end

  def generate_message
    case @event
    when "new_comment"
      paper_url = admin_activity_paper_url(@subject.paper.activity, @subject.paper)
      @message = "New Comment on <#{paper_url}#comment-#{@subject.id}|#{@subject.paper.title}>"
      @attachment = {
        text: "#{@subject.text}",
        ts: @subject.created_at.to_i,
      }
      attach_author_info! @attachment, @subject.user
      attach_activity_info! @attachment, @subject.paper.activity
    when "new_paper"
      paper_url = admin_activity_paper_url(@subject.activity, @subject)
      @message = "New Paper Submitted"
      @attachment = {
        title: @subject.title,
        title_link: paper_url,
        text: @subject.outline,
        ts: @subject.created_at.to_i,
      }
      attach_author_info! @attachment, @subject.user
      attach_activity_info! @attachment, @subject.activity
    when "paper_status_changed"
      paper_url = admin_activity_paper_url(@subject.activity, @subject)
      @message = "Paper Status Changed"
      case @subject.state
      when "reviewed"
        @attachment = {
          title: @subject.title,
          title_link: paper_url,
          text: "Paper reviewed",
          ts: @subject.updated_at.to_i,
        }
        attach_author_info! @attachment, @subject.reviews.last.user
      else
        @attachment = {
          title: @subject.title,
          title_link: paper_url,
          text: "State changed to #{@subject.state}",
          ts: @subject.updated_at.to_i,
        }
      end
      attach_activity_info! @attachment, @subject.activity
    end
  end
end
