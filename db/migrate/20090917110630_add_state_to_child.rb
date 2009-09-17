class AddStateToChild < ActiveRecord::Migration
  def self.up
    change_table :children do |t|
      t.string :state, :null => false
    end

    Child.reset_column_information

    StateMigrator.new.migrate!
  end

  def self.down
    change_table :children do |t|
      t.remove :state
    end
  end
end
