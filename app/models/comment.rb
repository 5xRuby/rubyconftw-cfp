class Comment < ApplicationRecord
  belongs_to :paper
  belongs_to :user
  validates :text, presence: true
end
