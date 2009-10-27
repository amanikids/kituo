class AddScheduledVisitsTable < ActiveRecord::Migration
  def self.up
    create_table :scheduled_visits do |table|
      table.with_options(:null => false) do |t|
        t.references :child

        t.date :scheduled_for
        t.timestamps
      end
    end

    add_index :scheduled_visits, [:child_id, :scheduled_for]
  end

  def self.down
    drop_table :scheduled_visits
  end
end
