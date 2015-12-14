class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @own_projects = Project.where("creator_id = #{session[:user_id]}")
  end

  def new
    @project = Project.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(session[:user_id])
    @project = @user.projects.create(project_params)
    #@project.users = @user
    @project.update_attribute('creator_id', session[:user_id] ) #Need a better way to do this. Don't need to make 2 database calls.
    if @project.save
      flash[:notice] = 'Project successfully created.'
      redirect_to(:action => 'index')
    else
      flash[:notice] = 'Error saving your project.'
      render('new')
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
        if @project.update_attributes(project_params)
          flash[:notice] = 'Successfully updated.'
          redirect_to(:action => 'index', id: session[:user_id])
        else
          flash[:notice] = 'Failed to update.'
          render('edit', id: @project.id)
        end
  end

  def delete
    @project = Project.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:notice] = 'Project deleted.'
    redirect_to(action: 'index')
  end

  private
    def project_params
      params.require(:project).permit(:name, :creator_id)
    end
end
