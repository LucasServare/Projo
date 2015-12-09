class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @user = User.find(session[:user_id])
  end

  def create
    @project = Project.new(project_params)
    @project.save
    if @project.save
      flash[:notice] = 'Project successfully created.'
      redirect_to(:action => 'index')
    else
      flash[:notice] = 'Error saving your project.'
      render('new')
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private
    def project_params
      params.require(:project).permit(:name, :creator_id)
    end
end
