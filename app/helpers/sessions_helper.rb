module SessionsHelper

  def sign_in(user)
    user.add_remember_token
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in_user?
    !!current_user
  end

  def require_signed_in
    unless signed_in_user?
      redirect_to signin_path
    end
  end

  def require_api_key
    unless !!User.find_by_api_key(params[:api_key])
      render :json => { :error => "go get an api key"}
    end
  end

end
