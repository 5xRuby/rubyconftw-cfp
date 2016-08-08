class CustomField < ApplicationRecord
  belongs_to :activity

  FIELD_TYPES = %w{text textarea number checkboxes select radios}

  ALLOWED_FIELD_TYPES_NOW = %w{text textarea checkboxes}
  DELIMITER = ","


  enum field_type: Hash[ALLOWED_FIELD_TYPES_NOW.map{|t| [t,t] }]

  validates :name, :sort_order, :field_type, presence: true
  validates :required, :options, presence: true, allow_blank: true


  def collection_text
    self.collection.join(DELIMITER)
  end

  def collection_text=(val)
    self.collection = val.split(DELIMITER)
  end


end
