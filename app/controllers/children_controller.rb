class ChildrenController < ApplicationController
  before_filter :build_child, :only => [:new, :create]
  before_filter :load_child,  :only => [:show, :edit, :update]

  def index
    redirect_to onsite_children_path
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

  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = t('children.update.notice', :name => @child.name)
      redirect_to @child
    else
      render :edit
    end
  end

  %w(onsite boarding_offsite reunified dropped_out terminated).each do |status|
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