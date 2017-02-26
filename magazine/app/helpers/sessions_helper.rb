module SessionsHelper

    def log_in user
      session[:user_id] = user.id
    end

    # returns the current user
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    #  checks if a user is logged in or not
    def logged_in?
      !current_user.nil?
    end

    # log out of account
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    # authentication of user
    def authenticate_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
