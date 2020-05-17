class SessionsController < ApplicationController

def new
  #login form
end

def create
  #actuslly try and login
  @form_data = params.require(:session)

  #pull out the username and password from  data
  @username = @form_data[:username]
  @password = @form_data[:password]

  #lets check the user is who they say they Are
  @user = User.find_by(username: @username).try(:authenticate, @password)

  #if there is a user present, redorect to homepage

  if @user
    #save user to their sessions

    session[:user_id] = @user.id

    redirect_to root_path
  else
    render "new"
  end

end

  def destroy
    #log us out
    #remove session completely
    reset_session

    #redirect to log in pages
    redirect_to new_session_path


  end

end
