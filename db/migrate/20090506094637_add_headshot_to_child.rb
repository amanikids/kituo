class AddHeadshotToChild < ActiveRecord::Migration
  def self.up
    change_table(:children) do |t|
      t.string   :headshot_file_name
      t.string   :headshot_content_type
      t.integer  :headshot_file_size
      t.datetime :headshot_updated_at
    end
  end

  def self.down
    change_table(:children) do |t|
      t.remove :headshot_file_name
      t.remove :headshot_content_type
      t.remove :headshot_file_size
      t.remove :headshot_updated_at
    end
  end
end
