class ApplicationController < ActionController::Base
    before_action :require_login
    helper_method :current_user

    def require_login
        redirect_to new_session_path unless session.include? :user_id
    end
  
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def check_user_role
        @user = User.find_by(id: session[:user_id])
        @recep = @user.role
        if @recep.id == 3 || @recep.id == 1 ||  @recep.id == 2
            
        else
            redirect_to home_users_path 
        end
    end
   
        
  
end
