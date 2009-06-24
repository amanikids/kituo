class AddCaseAssignmentIndexes < ActiveRecord::Migration
  def self.up
    add_index(:case_assignments, :child_id)
    add_index(:case_assignments, :social_worker_id)
  end

  def self.down
    remove_index(:case_assignments, :child_id)
    remove_index(:case_assignments, :social_worker_id)
  end
end
