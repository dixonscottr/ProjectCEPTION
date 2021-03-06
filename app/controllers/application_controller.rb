class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user || User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    redirect_to '/sessions/new' unless logged_in?
  end

  def require_not_logged_in
    redirect_to '/' if logged_in?
  end

  def is_admin?
    current_user && current_user.admin
  end

  def require_admin
    if !is_admin?
      flash[:notice] = "You do not have permission to view this page!"
      redirect_to root_path
    end
  end

  def round_two_maximum_met
    if Pitch.where(advancing: true).count >= 5
      return true
    end
  end

  def round_two?
    !!round_two_maximum_met
  end

end
