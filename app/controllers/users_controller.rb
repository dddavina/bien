class UsersController < ApplicationController

  def index
    #FORM FOR ADDING NEW USER
      @users = User.all
  end

   def show
      @user = User.find_by(username: params[:id])
   end

  def new
    #FORM FOR ADDING NEW USER
      @user = User.new
  end

  def create
  #TAKE THE PARAMS FROM THE form
  #CREATE A NEW User
  @user = User.new(form_params)
  #IF ITS VALID AND IT SAVES, GO TO list
  #IF NOT, SEE FORM WITH ERRORS
    if @user.save
      #save session with the user
      session[:user_id] = @user.id

       redirect_to users_path

    else
        render "new"
    end

  end

  def form_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)

  end

end
