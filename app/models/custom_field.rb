class CustomField < ActiveRecord::Base
  belongs_to :activity

  FIELD_TYPES = %w{text textarea number checkboxes select options}

  ALLOWED_FIELD_TYPES_NOW = %w{text textarea}

  enum field_type: ALLOWED_FIELD_TYPES_NOW.map(&:to_sym)

  #validates :name, :sort_order, :field_type, :required, :options, presence: true
  validates :name, :required, :description, presence: true

end
