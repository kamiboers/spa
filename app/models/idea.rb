class Idea < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :quality, inclusion: { in: %w(high medium low) }
end
