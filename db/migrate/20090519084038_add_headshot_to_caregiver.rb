class AddHeadshotToCaregiver < ActiveRecord::Migration
  SYSTEM = Rails.root.join('public', 'system')

  def self.up
    change_table(:caregivers) do |t|
      t.string   :headshot_file_name
      t.string   :headshot_content_type
      t.integer  :headshot_file_size
      t.datetime :headshot_updated_at
    end

    if SYSTEM.join('headshots').exist?
      SYSTEM.join('children').mkdir
      FileUtils.mv SYSTEM.join('headshots'), SYSTEM.join('children')
    end
  end

  def self.down
    if SYSTEM.join('caregivers').exist?
      SYSTEM.join('caregivers').rmtree
    end

    if SYSTEM.join('children').exist?
      FileUtils.mv SYSTEM.join('children', 'headshots'), SYSTEM
      SYSTEM.join('children').rmtree
    end

    change_table(:caregivers) do |t|
      t.remove :headshot_file_name
      t.remove :headshot_content_type
      t.remove :headshot_file_size
      t.remove :headshot_updated_at
    end
  end
end
