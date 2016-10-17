require 'rouge/plugins/redcarpet'

class RougeHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def rouge_formatter(lexer)
    Rouge::Formatters::HTMLLegacy.new(:css_class => "highlight #{lexer.tag}")
  end
end
