class Review < ApplicationRecord
  include AASM
  ALL_STATUS = %w{pending approved disapproved}

  belongs_to :user
  belongs_to :paper, counter_cache: true

  validates :paper, uniqueness: { scope: :user }
  validates :reviewed, inclusion: { in: %w(pending approve disapprove) }

  before_create -> { paper.view! } 

  aasm(column: :state) do
    state :pending , initial: true
    state *(ALL_STATUS[1..-1].map(&:to_sym))
    event :approve do
      transitions from: :pending , to: :approved
    end
    event :disapprove do
      transitions from: :pending, to: :disapproved
    end
  end
end
