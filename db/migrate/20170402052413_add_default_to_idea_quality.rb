class AddDefaultToIdeaQuality < ActiveRecord::Migration[5.0]
  def change
    change_column :ideas, :quality, :integer, default: 0
  end
end