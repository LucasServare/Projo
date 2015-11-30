class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(subject_params)
    if @user.save
      redirect_to(:action => 'edit_user_settings', id: @user.id)
    else
      render('new')
    end
  end

  def edit_user_settings
    @user = User.find(params[:id])
  end

  private
    def subject_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
