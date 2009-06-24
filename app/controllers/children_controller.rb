class ChildrenController < ApplicationController
  before_filter :build_child, :only => [:new, :create]
  before_filter :load_child,  :only => [:show, :edit, :update, :destroy]

  def index
    redirect_to onsite_children_path, :skip_contextual_magic => true
  end

  def create
    if @child.save
      flash[:notice] = t('children.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child, :skip_contextual_magic => true
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
      flash[:notice] = t('children.update.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :edit
    end
  end

  def destroy
    @child.destroy
    flash[:notice] = t('children.destroy.notice', :name => @child.name)
    redirect_to children_path, :skip_contextual_magic => true
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