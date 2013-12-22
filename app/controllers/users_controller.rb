class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit,  :update]
  before_filter :admin_user,     only:  :destroy
  before_filter :guest,          only: [:new,   :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome to the Sample App!"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])

    if current_user?(user)
      flash[:danger] = "Sorry, but you can't destroy yourself"
    elsif user.admin?
      flash[:danger] = "Sorry, but you can't destroy other admins"
    else
      user.destroy
      flash[:success] = "User destroyed"
    end

    redirect_to users_url
  end

  private

    def signed_in_user
      if signed_in?

      else
        store_location
        flash[:warning] = "Please sign in."
        redirect_to signin_url
      end
    end

    def guest
      if signed_in?
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
