class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: [:new, :create]

  def home 
    @user = User.find_by(id: session[:user_id])
  end
  
  def index
    @userall =User.all
    @user = User.find_by(id: session[:user_id])   
    @role=Role.all
  end

  def showmeeting
    @user = User.find_by(id: session[:user_id])   
    @usermeet=@user.mettings.all      
  end
  
  def show
    @user = User.find_by(id: session[:user_id])
    @userindex= User.find_by(id: params[:id])
  end

  def new
    @user = User.find_by(id: session[:user_id])
    @usernew= User.new
  end

  def create
    @usernew = User.create(user_params)
    respond_to do |format|
      if @usernew.save
        format.html { redirect_to users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_path  
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :address, :password, :role_id)
    end
end
