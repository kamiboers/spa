class Idea < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  enum quality: [:low, :medium, :high]
end
