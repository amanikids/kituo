class CreateCaseAssignments < ActiveRecord::Migration
  def self.up
    create_table :case_assignments do |t|
      t.references :child
      t.references :social_worker
      t.timestamps
    end
  end

  def self.down
    drop_table :case_assignments
  end
end
