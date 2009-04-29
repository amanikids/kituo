class CreateArrivals < ActiveRecord::Migration
  def self.up
    create_table :arrivals do |t|
      t.belongs_to :child
      t.date :happened_on

      t.timestamps
    end
  end

  def self.down
    drop_table :arrivals
  end
end
