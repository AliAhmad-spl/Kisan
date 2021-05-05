class UsersController < ApplicationController
  before_action :set_user, except: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.update(stripe_token: current_user.stripe_token, token_updated_at: current_user.token_updated_at) if current_user.stripe_token.present?
    redirect_to :root
  end

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to :root, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find_by_id(current_user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :company_name, :address, :phone, :password, :password_confirmation, :company_id)
    end
end
