class AddDeletedAtToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :deleted_at, :string
    add_column :stories, :datetime, :string
    add_index :stories, :datetime
  end
end
