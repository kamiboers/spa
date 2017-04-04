class Idea < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :quality, inclusion: { in: %w(high medium low) }
end
