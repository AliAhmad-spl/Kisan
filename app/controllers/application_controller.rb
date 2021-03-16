class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
    if session[:cart_id].nil?
      @current_cart = Cart.create!(user_id: current_user.id)
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  helper_method :current_cart
end
