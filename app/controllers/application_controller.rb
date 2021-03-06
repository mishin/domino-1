class ApplicationController < ActionController::Base
  protect_from_forgery

  include RedisSupport

  before_filter :localization

  def localization
    if current_user
      I18n.locale = current_user.get_locale || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  def online_game?
    params[:controller] == 'dd/games' && params[:action] == 'show'
  end

  helper_method :online_game?

  # Authorized user
  def current_user
    return @current_user if defined?(@current_user)
    return nil if cookies[:remember_me_token].blank?

    @current_user = User.find_by_remember_me_token(cookies[:remember_me_token])
    if @current_user #&& @current_user.adjust_attributes
      @current_user.save!
    end
    @current_user
  end

  def send_sms!
    @nexmo = Nexmo::Client.new(NEXMO_CONFIG[:api_key], NEXMO_CONFIG[:api_secret])
    response = @nexmo.send_message({:to => current_user.phone, :from => 'Dynamic Games ', :text => 'Hello world from Dd'})

    if response.ok?
      puts 'SMS SENT!!!!!!'
    else
      # handle the error
    end
  end

  helper_method :current_user

  # Anonymous user
  def visitor_user
    return @visitor_user if defined?(@visitor_user)

    @visitor_user = User.find_by_remember_me_token(cookies[:remember_me_token]) unless cookies[:remember_me_token].blank?
  end

  helper_method :visitor_user

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?

  def logout

    reset_user_session
    reset_session

    redirect_to root_path
  end

  def reset_user_session
    cookies[:remember_me_token] = nil
    cookies.permanent[:remember_me_token] = nil
  end

  def redirect_to_with_notice(options = { }, notice = nil, type = :notice)
    redirect_to options, :flash => { type => notice }
  end

  # we redirect only first time
  def redirect_to(options = { }, response_status = { }) #:doc:
    unless response_body
      super(options, response_status)
    end
  end

  def users_online
    User.logged_in_count
  end
  helper_method :users_online

end
