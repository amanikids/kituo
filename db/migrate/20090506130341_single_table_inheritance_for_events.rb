class SingleTableInheritanceForEvents < ActiveRecord::Migration
  def self.up
    rename_table :arrivals, :events
    add_column :events, :type, :string
    execute 'UPDATE events SET type="Arrival"'
  end

  def self.down
    remove_column :events, :type
    rename_table :events, :arrivals
  end
end
