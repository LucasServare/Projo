class PublicController < ApplicationController

  def home
    if current_user
      if confirm_logged_in
        redirect_to(:controller => 'UserAccess', :action => "logged_in_home", :id => session[:user_id])
      end
    end
  end
end
