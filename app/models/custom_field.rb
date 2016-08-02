class CustomField < ActiveRecord::Base
  belongs_to :activity

  FIELD_TYPES = %w{text textarea number checkboxes select options}

  ALLOWED_FIELD_TYPES_NOW = %w{text textarea}


  enum field_type: Hash[ALLOWED_FIELD_TYPES_NOW.map{|t| [t,t] }]

  validates :name, :sort_order, :field_type, presence: true
  validates :required, :options, presence: true, allow_blank: true

end
