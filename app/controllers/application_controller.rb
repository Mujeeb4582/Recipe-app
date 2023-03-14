class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @user = User.find_by(id: 7)
  end
end
