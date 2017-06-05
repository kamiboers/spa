class Task < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  def toggle_completion
    self.update({complete: !self.complete})
  end

end
