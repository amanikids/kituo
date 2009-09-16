class AddLocationToChild < ActiveRecord::Migration
  def self.up
    change_table :children do |t|
      t.string :location, :null => false, :default => ''
    end
  end

  def self.down
    change_table :children do |t|
      t.remove :location
    end
  end
end
