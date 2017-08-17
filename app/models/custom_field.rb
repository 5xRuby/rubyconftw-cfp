class CustomField < ApplicationRecord
  belongs_to :activity

  FIELD_TYPES = %w{text textarea number checkboxes selects radios}

  ALLOWED_FIELD_TYPES_NOW = %w{text textarea checkboxes selects radios}
  DELIMITER = ","

  FIXED_SEARCH_FIELDS = %w(state country speaker_bio tag)


  enum field_type: Hash[ALLOWED_FIELD_TYPES_NOW.map{|t| [t,t] }]

  validates :name, :sort_order, :field_type, presence: true

  # TODO: Assert why validate presence but allow blank
  validates :required, :options, presence: true, allow_blank: true

  validate :validate_custom_fields_name


  def collection_text
    self.collection.join(DELIMITER)
  end

  def collection_text=(val)
    self.collection = val.split(DELIMITER)
  end

  def validate_custom_fields_name
    errors[:name] << "invalid field name" if FIXED_SEARCH_FIELDS.include? self.name
  end

end
