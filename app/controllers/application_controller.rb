class ApplicationController < ActionController::Base
  helper_method :current_account, :account_signed_in?
  protect_from_forgery with: :exception

  private

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id]) if session[:account_id]
  end

  def account_signed_in?
    current_account.present?
  end

  def authenticate_account!
    redirect_to login_path, alert: "You must be logged in to access this page." unless account_signed_in?
  end
end
