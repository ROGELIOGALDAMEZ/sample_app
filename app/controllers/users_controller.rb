class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update] #used as part of redirecting users to sign_in before they can edit settings
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @users = User.all
    @title = "All Users"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user  = User.new
    @title = "Sign Up"
  end
  
  def create
    @user  = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user 
    else
      @title = "Sign Up"
      render 'new'      
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #it worked
      flash[:success] = "Profile updated."
      redirect_to @user 
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  
  private 
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) 
  end
  
  
end
