class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @account_id = params[:account_id]
    @account = Account.find_by(id: params[:account_id])
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    respond_to do |format|
      if @payment.save
        @account = Account.find_by(id: params[:payment][:account_id]) if params[:payment][:account_id].present?
        @payment.update(current_balance: @account.remaining_balance - @payment.amount)
        Order.create(user_id: current_user.id, company_id: current_user.company.id, name: @payment.account.party_name, status: params[:payment][:status], total_amount: @payment.amount)
        @account.update(total_credit: @account.total_credit + @payment.amount, remaining_balance: @account.remaining_balance - @payment.amount) if params[:payment][:account_id].present?
        format.html { redirect_to account_path(id: @account.id), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to account_path(id: params[:account_id]), notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:account_id, :customer_name, :amount, :status, :current_balance)
    end
end
