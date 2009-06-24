class AddEventIndexes < ActiveRecord::Migration
  def self.up
    add_index(:events, :child_id)
    add_index(:events, :type)
    add_index(:events, :created_at)
    add_index(:events, :happened_on)
  end

  def self.down
    remove_index(:events, :child_id)
    remove_index(:events, :type)
    remove_index(:events, :created_at)
    remove_index(:events, :happened_on)
  end
end
