class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]

  def index
    @members = User.all
  end

  def new
    @member = User.new
  end

  def edit; end

  def create
    @member = User.new(member_params)
    if @member.save
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
    params.require(:user).permit(:name, :email, :phone, :role, :password)
  end
end
