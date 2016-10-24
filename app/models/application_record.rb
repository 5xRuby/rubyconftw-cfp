class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.markdown(content)
    @@markdown_renderer ||= ::RougeHTML.new(filter_html: true)
    @@markdown ||= Redcarpet::Markdown.new(@@markdown_renderer, autolink: true, fenced_code_blocks: true)

    @@markdown.render(content || "")
  end
end
