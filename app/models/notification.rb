class Notification
  include ActiveModel::Model
  include ActiveModel::Serialization
  include GlobalID::Identification

  attr_accessor :subject, :content

  validates :subject, presence: true
  validates :content, presence: true

  def id
    Base64.strict_encode64(to_json(only: ["subject", "content"]))
  end

  def self.find(id)
    Notification.new(JSON.parse(Base64.strict_decode64(id)))
  end

  def html_content
    return markdown(yield content) if block_given?
    markdown(content)
  end

  protected
  def markdown(content)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true)

    markdown.render(content)
  end
end
