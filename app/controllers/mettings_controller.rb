class MettingsController < ApplicationController
    before_action :check_user_role , except: [:edit, :update]
    before_action :set_metting, only: %i[ show edit update destroy ]
    def index
        @user = User.find_by(id: session[:user_id])
        @mettingall = Metting.all
    end

    def new
        @user = User.find_by(id: session[:user_id])
        @metting=Metting.new
    end

    def show
    end
    
    def create 
        @metting = Metting.new(metting_params)
        if @metting.save
            redirect_to guests_path
        end
    end

    def edit
    end

    def update
        respond_to do |format|
          if @metting.update(metting_params)
            format.html { redirect_to home_users_path, notice: "Meet was successfully updated." }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
    end
    private
        def set_metting
            @metting = Metting.find(params[:id])
        end
        def metting_params
            params.require(:metting).permit(:guest_id, :user_id,:purpose,:status)
        end
end
