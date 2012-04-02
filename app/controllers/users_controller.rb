class UsersController < ApplicationController
  
  def validUsernamePassword?
    user = User.find_by_username(params[:username])
    if user and user.has_password?(params[:password])
     render :text => "OK"
    else
     render :nothing => true
    end 
  end 

  def new
    @user = User.new
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @users = User.find(params[:id])
    @users.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

 
  def create
    @user = User.new(params[:user])
    if @user.save
    
    respond_to do |format|
      if @user.save
        format.html {redirect_to(@user, :notice => 'User was successfully created')}
      end
    end
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
