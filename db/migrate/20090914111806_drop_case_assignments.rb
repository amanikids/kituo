class DropCaseAssignments < ActiveRecord::Migration
  class Child < ActiveRecord::Base
    has_one :case_assignment, :class_name => 'DropCaseAssignments::CaseAssignment'
    belongs_to :social_worker, :class_name  => 'Caregiver'
  end

  class CaseAssignment < ActiveRecord::Base
    belongs_to :social_worker, :class_name => 'Caregiver'
  end

  def self.up
    change_table :children do |t|
      t.references :social_worker
    end

    Child.reset_column_information
    Child.find_each do |child|
      next unless child.case_assignment

      child.social_worker = child.case_assignment.social_worker
      child.save!
    end

    drop_table :case_assignments
  end

  def self.down
    create_table :case_assignments do |t|
      t.references :child
      t.references :social_worker
      t.timestamps
    end

    Child.find_each do |child|
      next unless child.social_worker

      child.create_case_assignment(:social_worker => child.social_worker)
    end

    change_table :children do |t|
      t.remove_references :social_worker
    end
  end
end
