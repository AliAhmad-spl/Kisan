class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy available_quantity]

  def index
    @items = current_company.items
  end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    params[:item][:remaining_quantity] = params[:item][:quantity]
    @item = Item.new(item_params)
    if @item.save
      redirect_to :root, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to :root, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  def available_quantity
    key = params['key'].to_i
    if @item&.quantity.to_i >= key
      render json: { "valid": true }
    else
      render json: { "valid": false, "quantity": @item.quantity }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(Item::WHITELIST_PARAMS)
  end
end
