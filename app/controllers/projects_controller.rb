class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects
    @own_projects = Project.where("creator_id = #{session[:user_id]}")
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @user = current_user
  end

  def create
    @user = current_user
    @project = @user.projects.create(project_params)
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
    @user = current_user
  end

  def destroy
    @project = Project.find(params[:id])
    if current_user.id == @project.creator_id
      Project.find(params[:id]).destroy
      flash[:notice] = 'Project deleted.'
      redirect_to(action: 'index')
    else
      flash[:notice] = 'Sorry, only the creator can delete a project.'
      redirect_to(:back)
    end
  end

  def add_user
    if user_to_add = User.find_by("email = '#{params[:email]}'") #Don't forget to sanitize this!
      project = Project.find(params[:id])
      if project.users.ids.exclude?(user_to_add.id) #I'm sure there's a much better way to do this, but I can't do this with validations without using a through model.
        project.users << user_to_add
        flash[:notice] = 'User successfully added.'
        redirect_to :back
      else
        flash[:notice] = 'Sorry, that user is already a part of this project.'
        redirect_to :back
      end
    else
      flash[:notice] = "Can you double check that email? We can't seem to find that user."
      redirect_to :back
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :creator_id)
    end
end
