class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]

  def index
    @members = current_company.users
  end

  def new
    @member = User.new
  end

  def edit; end

  def create
    @member = User.new(member_params)
    if @member.save
      @member.update(stripe_token: current_user.stripe_token, token_updated_at: current_user.token_updated_at) if current_user.stripe_token.present?
      redirect_to :root, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  def update
    if @member.update(member_params)
      redirect_to :root, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to :root, notice: 'Member was successfully destroyed.'
  end

  private

  def set_member
    @member = User.find(params[:id])
  end

  def member_params
    params.require(:user).permit(:name, :company_id, :email, :phone, :role, :password)
  end
end
