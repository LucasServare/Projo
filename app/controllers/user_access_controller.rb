class UserAccessController < ApplicationController


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
      puts "authorized!"
      #mark them as logged in
    else
      redirect_to(:action =>  'login_attempt')
    end

  end

  def logout
  end
end
