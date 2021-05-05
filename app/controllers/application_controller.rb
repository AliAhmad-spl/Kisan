class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :check_payment

  def check_payment
    if current_user&.stripe_token&.present?
      return true 
    else
      if current_user.present?
        redirect_to new_charge_path
      end
    end
  end

  def current_company
    @current_company = current_user.company
  end
  
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
