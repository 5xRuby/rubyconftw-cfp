# frozen_string_literal: true

class PapersJSONExporter
  include Rails.application.routes.url_helpers
  attr_accessor :collection

  class << self
    attr_writer :default_url_options

    def default_url_options
      @default_url_options ||= {
        host: (Settings&.app_host rescue 'cfp.rubyconf.tw')
      }
    end
  end

  def initialize(collection)
    @collection = collection
  end

  def perform
    collection.map do |paper|
      user = paper.user
      {
        name: user.name,
        title: user.title_with_company,
        avatar: user.full_avatar_url(self.class.default_url_options[:host]),
        twitter: user.twitter_url,
        github: user.github_url,
        lang: (paper.language == "English" ? 'en' : 'ch' ),
        subject: paper.title,
        summary: paper.abstract
      }.stringify_keys
    end
  end

end
