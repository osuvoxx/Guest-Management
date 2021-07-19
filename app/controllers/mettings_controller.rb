class MettingsController < ApplicationController
    before_action :check_user_role , except: [:edit, :update]
    before_action :set_metting, only: %i[ show edit update destroy ]
    def index
        @user = User.find_by(id: session[:user_id])
        @mettingall = Metting.all.order("updated_at DESC")
        @active="all"
        @date=Time.now

    end

    def new
        @user = User.find_by(id: session[:user_id])
        @metting=Metting.new
        
    end

    def show
    end
    
    def create 
        @metting = Metting.new(metting_params)
        @metting.reschedule=Time.now
        if @metting.save
            redirect_to guests_path
        end
    end

    def edit
    end

    def notification
        @mettingall = p = ActiveRecord::Base.connection.execute("SELECT mettings.status,users.name FROM mettings JOIN users ON mettings.user_id = users.id ")
        render json:{meet: @mettingall}
    end
    
      def update
        @user = User.find_by(id: session[:user_id])
        respond_to do |format|
          if @metting.update(metting_params)
            if @user.role.id == 3
                format.html { redirect_to mettings_path}
            else
                format.html { redirect_to home_users_path}
            end
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
            params.require(:metting).permit(:guest_id, :user_id,:purpose,:status,:reschedule,:reason)
        end
end
