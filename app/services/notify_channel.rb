class NotifyChannel < ActiveJob::Base
  queue_as :default

  def self.default(key, value)
    @@defaults ||= {} 
    @@defaults[key] = value
  end

  def perform(service_info, event, subject)
    @service_info = service_info
    @event = event
    @subject = subject
    fill_default_values
    setup
    generate_message
    notify
  rescue RuntimeError => e
    handle_error(e.to_s)
  end

  def setup

  end

  def notify
    Rails.logger.info @message
  end

  def generate_message
    case @event
    when "new_comment"
      @message = "[New Comment on #{@subject.paper.title}]\n#{@subject.user.name}: #{@subject.text}"
    when "new_paper"
      @message = "[New Paper Submitted by #{@subject.user.name}]\n#{@subject.title}"
    when "paper_status_changed"
      case @subject.state
      when "reviewed"
        @message = "[Paper Status Changed]\n[#{@subject.title}] reviewed by #{@subject.reviews.last.user.name}"
      else
        @message = "[Paper Status Changed]\n[#{@subject.title}] changed to #{@subject.state}"
      end
    end
  end

  def handle_error(error)
    Rails.logger.error "#{self.class} Error: #{error}"
  end
  
  def fill_default_values
    @@defaults.each do |key, field|
      if @service_info[key].blank?
        @service_info[key] = field
      end
    end
  end

end
