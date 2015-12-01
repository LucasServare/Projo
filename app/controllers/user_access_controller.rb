class UserAccessController < ApplicationController

  before_action :confirm_logged_in,
    :except => [:login, :login_attempt, :logout]

  def home
  end

  def login
  end


  def login_attempt
    if params[:email].present? && params[:password].present?
      user = User.where(:email => params[:email]).first
      if user #will return true if an object is returned, as objects in rails are truthy
        authorized_user = user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      #mark them as logged in
    else
      flash[:notice] = 'Invalid login.'
      redirect_to(:action =>  'login_attempt')
    end
  end

  def logout
    session[:user_id] = nil
    session[:email] = nil
  end

  private

    def confirm_logged_in
      unless session[:user_id]
        flash[:notice] = 'Please log in first.'
        redirect_to(:action => 'login')
        return false #this is for the before_action at the beginning of the controller
      else
        return true
      end
    end

end
