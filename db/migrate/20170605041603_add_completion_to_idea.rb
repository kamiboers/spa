class AddCompletionToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :complete, :boolean
  end
end
