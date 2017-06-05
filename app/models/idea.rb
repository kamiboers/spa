class Idea < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :quality, inclusion: { in: %w(high medium low) }

  def toggle_completion
    idea.update(complete=!idea.complete)
  end

end
