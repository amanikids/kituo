class AddPotentialDuplicateFlagToChild < ActiveRecord::Migration
  def self.up
    change_table :children do |t|
      t.boolean :potential_duplicate, :null => false
    end

    Child.update_all(:potential_duplicate => false)
  end

  def self.down
    change_table :children do |t|
      t.remove :potential_duplicate
    end
  end
end
