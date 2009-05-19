class Children::CaseAssignmentsController < Children::BaseController
  before_filter :build_case_assignment, :only => [:new, :create]

  def create
    if @case_assignment.save
      flash[:notice] = t('children.case_assignment.create.notice', :child_name => @case_assignment.child_name, :social_worker_name => @case_assignment.social_worker_name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_case_assignment
    redirect_to edit_child_case_assignment_path(@child) if @child.case_assignment
    @case_assignment = @child.build_case_assignment(params[:case_assignment])
  end
end
