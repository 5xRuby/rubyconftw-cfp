# frozen_string_literal: true

class PapersXLSXExporter
  include Rails.application.routes.url_helpers
  attr_accessor :collection, :dir_path, :file_name, :wbk, :current_wsh
  FIELDS = %w[id activity_name speaker_name speaker_email language title abstract outline pitch user_github_url speaker_bio ].freeze
  I18N_NAMESPACE = 'exporter.papers'

  class << self
    attr_writer :default_url_options

    def default_url_options
      @default_url_options ||= {
        host: (Settings&.app_host rescue 'cfp.rubyconf.tw')
      }
    end
  end

  def file_path
    File.join(dir_path, file_name)
  end

  def initialize(collection, dir_path = '/tmp', file_name = "#{SecureRandom.hex(4)}.xlsx")
    @collection, @dir_path, @file_name = collection, dir_path, file_name
    @wbk = WriteXLSX.new(file_path, strings_to_urls: false)
    @current_wsh = @wbk.add_worksheet
  end

  def collection_as_json
    @collection_as_json ||= collection.map do |obj|
      values = FIELDS.map {|f| obj.send(f) }
      row = Hash[FIELDS.zip(values)]
      row["activity_name"] = admin_activity_paper_url(obj.activity, obj)
      row
    end
  end

  def title_row
    @title_row ||= FIELDS.map{|f| I18n.t("#{I18N_NAMESPACE}.#{f}") }
  end

  def perform
    current_wsh.write_row 0, 0, title_row
    ridx = 1
    collection_as_json.each do |row|
      vals = row.values
      current_wsh.write_row ridx, 0, vals
      ridx += 1
    end
    wbk.close
    file_path
  end
end
