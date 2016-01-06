class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:email] = @user.email
      WelcomeMailer.welcome_email(@user).deliver
      redirect_to(:controller => 'user_access', :action => 'logged_in_home', id: @user.id)
    else
      flash[:notice] = 'Please ensure your passwords match.'
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          flash[:notice] = 'Successfully updated.'
          redirect_to(:action => 'edit', id: @user.id)
        else
          flash[:notice] = 'Failed to update.'
          render('edit', id: @user.id)
        end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:current_password]) && params[:user][:password] == params[:user][:password_confirmation]
      @user.update_attribute(:password, params[:user][:password])
      flash[:notice] = 'Updated password.'
      redirect_to(:action => 'edit', id: @user.id)
    else
      flash[:notice] = 'Failed to update password.'
      redirect_to(:action => 'edit', id: @user.id)
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
