class ApplicationController < ActionController::Base

#protect_from_forgery with: :exception
#before any ;age loads find current users

  before_action :find_current_user

  #add method to use in the views

  helper_method :is_logged_in?

  def find_current_user
     if is_logged_in?
          @current_user = User.find(session[:user_id])
      else
         @current_user = nil
     end
  end

    #chrck login status

  def check_login
    unless is_logged_in?
        redirect_to new_session_path
    end
  end

  #is the person logged in

  def is_logged_in?
    session[:user_id].present?

  end

end
