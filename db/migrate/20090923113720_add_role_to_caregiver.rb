class AddRoleToCaregiver < ActiveRecord::Migration
  def self.up
    change_table :caregivers do |t|
      t.string :role, :null => false, :default => 'social_worker'
    end
  end

  def self.down
    change_table :caregivers do |t|
      t.remove :role
    end
  end
end
