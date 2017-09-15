class Review < ApplicationRecord
  belongs_to :user
  belongs_to :paper, counter_cache: true

  validates :paper, uniqueness: { scope: :user }
  validates :reviewed, inclusion: { in: %w(pending approve disapprove) }

  before_create -> { paper.view! }
end
