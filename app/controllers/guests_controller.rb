class GuestsController < ApplicationController
    before_action :set_guest, only: %i[ show edit update destroy ]
    before_action :check_user_role
    def show
        @user = User.find_by(id: session[:user_id])
        @guest=Guest.find_by(id: params[:id])
       
    end

    def meeting 
        @user = User.find_by(id: session[:user_id])
        @active="meeting"
        @guest = Guest.where(params[search])
        @guestnew = Guest.new
        @guestnew.mettings.build
        # @guestnew.messages.build
        
    end

    def search
        @guestfind = Guest.search(params[:search])
        @count=0
        if !@guestfind.nil?
            @status=@guestfind.mettings.all
            @status.each do |status| 
                if status.status == "3" || status.status == "4" 
                @count = @count + 1
                @check= status
                end 
            end
        end
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
            flash[:notice] = "Metting Scheduled Succesfully"
            redirect_to meeting_guests_path
        else
            redirect_to meeting_guests_path
        end
    end

    def update
        @user = User.find_by(id: session[:user_id])

        respond_to do |format|        
            if @guest.update(guest_params)
                flash[:notice] = "Metting Scheduled Succesfully"
                format.html { redirect_to meeting_guests_path}
            else
                format.html { redirect_to meeting_guests_path, status: :unprocessable_entity }
            end
        end
    end


    private
        def set_guest
            @guest = Guest.find(params[:id])
        end

       
        def guest_params
            params.require(:guest).permit(:name,:email,:phone,:address,mettings_attributes: [:id,:user_id,:purpose,:status,:reschedule])
        end
end
