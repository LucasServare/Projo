class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

    def confirm_logged_in
      unless session[:user_id]
        flash[:notice] = 'Please log in first.'
        redirect_to(:controller => 'user_access', :action => 'login')
        return false #this is for the before_action at the beginning of each controller.
      else
        return true
    end
  end


end
