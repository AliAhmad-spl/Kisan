class CartsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy remove clear]

  def create
    # params[:item][:remaining_quantity] = params[:item][:quantity]
    # @reservation = ItemReservation.new(item_reservation_params)
    # if @reservation.save
    #   redirect_to :root, notice: 'Item added to cart successfully.'
    # else
    #   render :new
    # end
  end

  def show
    @cart = current_cart
  end

  def clear
    @reservation.line_items.destroy_all
    redirect_to root_path
  end

  def remove
    item = @reservation.line_items.find_by(id: params[:item_id])
    item.destroy
    redirect_to cart_path(id: @reservation.id)
  end

  def add_to_cart
    current_cart.add_item(params[:line_item][:item_id], params[:line_item][:quantity])
    session[:cart_id] = current_cart.id if current_cart.present?
    redirect_to items_path
  end

  def update
    if @reservation.update(item_reservation_params)
      redirect_to :root, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def set_reservation
    @reservation = Cart.find(params[:id])
  end

  def item_reservation_params
    params.require(:cart).permit(Cart::WHITELIST_PARAMS)
  end
end
