class Notification
  include ActiveModel::Model

  attr_accessor :subject, :content

  validates :subject, presence: true
  validates :content, presence: true

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
