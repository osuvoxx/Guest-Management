class GuestsController < ApplicationController
    before_action :set_guest, only: %i[ show edit update destroy ]
    before_action :check_user_role
    def show
        @user = User.find_by(id: session[:user_id])
        @guest=Guest.find_by(id: params[:id])
       
    end

    def meeting 
        @user = User.find_by(id: session[:user_id])
        
        @guest = Guest.where(params[search])
        @guestnew = Guest.new
        @guestnew.mettings.build
        # @guestnew.messages.build
        
    end

    def search
        @guestfind = Guest.search(params[:search])
    end

    def index
        @user = User.find_by(id: session[:user_id])
        @guests=Guest.all
    end

    # def new
    #     @user = User.find_by(id: session[:user_id])
    #     @guest= Guest.new
    # end
    def edit

    end
    def create
        @user = User.find_by(id: session[:user_id])
        @guestnew= Guest.create(guest_params)
        if @guestnew.save
            redirect_to meeting_guests_path
        else
            render :new
        end
    end

    def update
        @user = User.find_by(id: session[:user_id])

        respond_to do |format|        
            if @guest.update(guest_params)
                format.html { redirect_to guests_path, notice: "Meeting Scheduled." }
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end


    private
        def set_guest
            @guest = Guest.find(params[:id])
        end

       
        def guest_params
            params.require(:guest).permit(:name,:email,:phone,:address,mettings_attributes: [:id,:user_id,:purpose,:status])
        end
end
