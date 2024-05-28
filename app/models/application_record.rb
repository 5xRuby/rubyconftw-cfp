class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.markdown(content)
    Kramdown::Document.new(content, syntax_highlighter: :rouge, input: 'GFM').to_html
  end
end
