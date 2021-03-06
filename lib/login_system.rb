module LoginSystem
  protected

  def is_logged_in?
    @logged_in_user = User.find(session[:user]) if session[:user]
  end

  def logged_in_user
    return @logged_in_user if is_logged_in?
  end

  def logged_in_user=(user)
    if !user.nil?
      session[:user] = user.id
      @logged_in_user = user
    end
  end

  def self.included(base)
    base.send :helper_method, :is_logged_in?, :logged_in_user
  end

  def login_required
    unless is_logged_in?
      flash[:error] ="您必须首先登陆!"
      redirect_to :controller=> 'account', :action=> 'login'
    end
  end
end