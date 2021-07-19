class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: [:new, :create]

  def home 
    @user = User.find_by(id: session[:user_id]) 
    @activeuser = User.find_by(id: session[:user_id]) 
    @date=Time.now;
    @active="home"
  end
  
  def index
    @userall =User.all
    @user = User.find_by(id: session[:user_id])   
    @role=Role.all
    @active="index"
  end

  def showmeeting
   @active = "show"
    @user = User.find_by(id: session[:user_id])   
    @usermeet=@user.mettings.all.where(status: "0").order("created_at DESC")
    # render json:{usermeet: @usermeet}
  end

  def ajaxshow
    @user = User.find_by(id: session[:user_id])   
    @usermeet=@user.mettings.all
    render json:{usermeet: @usermeet}
    
  end

  # def notification
  #   @mettingall = Metting.all
  #   render json:{meet: @mettingall}
  # end

  def show
    @active="profile"
    @user = User.find_by(id: session[:user_id])
    @userindex= User.find_by(id: params[:id])
  end

  def new
    @active="index"
    @user = User.find_by(id: session[:user_id])
    @usernew= User.new
  end

  def create
    @usernew = User.create(user_params)
    respond_to do |format|
      if @usernew.save
        format.html { redirect_to users_path }
        flash[:notice] = "Employee Created Successfully"
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @active="profile"
    
  end

  def update
   
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = "Employee Updated Successfully"
        format.html { redirect_to user_path(@user) }
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
