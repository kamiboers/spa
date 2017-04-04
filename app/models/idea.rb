class Idea < ApplicationRecord
  validates :title, :body, presence: true

  enum quality [:low, :medium, :high]
end
