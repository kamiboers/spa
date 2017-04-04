class ChangeIdeaQualityFromIntegerToString < ActiveRecord::Migration[5.0]
  def change
    change_column :ideas, :quality, :string, default: "low"
  end
end
