class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:email] = @user.email
      redirect_to(:controller => 'user_access', :action => 'logged_in_home', id: @user.id)
    else
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    flash[:notice] = 'Successfully updated.'
    if @user.update_attributes(user_params)
      redirect_to(:action => 'edit', id: @user.id)
    else
      render('new')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'Account deleted.'
    redirect_to(:action => 'home', :controller => 'public')
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
