class ChildrenController < ApplicationController
  before_filter :build_child, :only => [:new, :create]
  before_filter :load_child,  :only => [:show]

  def index
    if Child.pending.count.zero?
      redirect_to onsite_children_path
    else
      redirect_to pending_children_path
    end
  end

  def create
    if @child.save
      flash[:notice] = t('children.create.notice', :name => @child.name)
      redirect_to @child
    else
      if @child.potential_duplicates.any?
        render :potential_duplicates_found
      else
        render :new
      end
    end
  end

  %w(pending onsite boarding_offsite reunified dropped_out terminated).each do |status|
    define_method(status) do
      @children = Child.send(status)
    end
  end

  protected

  def build_child
    @child = Child.new(params[:child])
  end

  def load_child
    @child = Child.find(params[:id])
  end
end