class CustomFieldAnswer < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  belongs_to :custom_field

  def self.stats(base_count = nil)
    stats = group(:answer).size
    return stats if base_count.nil?
    unknowns = stats.values.sum - base_count
    return stats unless unknowns != 0
    stats["Unknown"] = unknowns.abs
    stats
  end
end
