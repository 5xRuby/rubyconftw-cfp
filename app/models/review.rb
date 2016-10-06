class Review < ApplicationRecord
  belongs_to :user
  belongs_to :paper, counter_cache: true

  validates :paper, uniqueness: { scope: :user }

  before_create -> { paper.view! }
end
