class CreateCaregivers < ActiveRecord::Migration
  def self.up
    create_table :caregivers do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :caregivers
  end
end
