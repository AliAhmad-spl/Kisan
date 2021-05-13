class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = current_company.orders.last(8)
    @members = current_company.users
    @items = current_company.items
  end

  def old
    @orders = current_company.orders
  end

  def renew
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.renew(params[:id])
    redirect_to :root
    flash[:notice] = 'Renewed for 7 days from now. Enjoy!'

    begin
      OrderMailer.delay.renew_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def disable
    borrowed_qty = Order.find_by_id(params[:id]).quantity.to_i
    @borrowed_item = Order.find_by_id(params[:id]).item
    @borrowed_item.increment!(:remaining_quantity, borrowed_qty)
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.disable(params[:id])
    redirect_to :root
    flash[:notice] = 'Item marked as returned. Thank you!'

    begin
      OrderMailer.delay.return_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def show
    
  end

  def new
    @order = Order.new
    @member = User.all
  end

  def create  
    @cart = Cart.find_by(id: params[:id])
    @order = Order.create(name: params[:name], user_id: current_user.id, company_id: current_user.company.id, status: params[:status])
    if @cart.line_items.update_all(order_id: @order.id)
      @cart.line_items.each do |e|
        e.item.update(quantity: e.item.quantity - e.quantity)
      end
      @cart.line_items.update_all(cart_id: nil)
    end
    @account = Account.find_by(id: params[:account_id]) if params[:account_id].present?
    @payment = Payment.create(account_id: params[:account_id], order_id: @order.id, customer_name: params[:name], amount: @order.line_items.sum(:price), status: params[:status], current_balance: @account.remaining_balance + @order.line_items.sum(:price)) if params[:account_id].present?
    @account.update(total_debit: @account.total_debit + @payment.amount, remaining_balance: @account.remaining_balance + @payment.amount) if params[:account_id].present?

    redirect_to order_path(id: @order.id)
    # if Item.find_by_id(params[:order][:item_id]).remaining_quantity >= params[:order][:quantity].to_i
    #   params[:order][:status] = true
    #   @order = Order.new(order_params)
    #   if @order.save
    #     @current_user = current_user
    #     @borrowed_item = Item.find_by_id(params[:order][:item_id])
    #     @borrowed_item.decrement!(:remaining_quantity, params[:order][:quantity].to_i)
    #     redirect_to :root, notice: 'Order was successfully created.'
    #     begin
    #       OrderMailer.delay.create_order(@order, @current_user).deliver
    #     rescue Exception => e
    #     end
    #   else
    #     render :new
    #   end
    # else
    #   flash[:alert] = 'The quantity you entered is not currently available'
    #   redirect_to :back
    # end
  end

  def destroy
    @order.line_items.present?
    @order.line_items.each do |e|
      e.item.update(quantity: e.item.quantity + e.quantity)
    end
    @order.destroy

    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:quantity, :company_id, :expire_at, :status, :item_id, :member_id)
  end
end
