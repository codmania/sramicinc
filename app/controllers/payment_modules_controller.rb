class PaymentModulesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_payment_module, only: [:show,:edit,:update,:destroy]
  def index
  end

  def edit
    @paymentmodule=PaymentModule.first
  end

  def update
    respond_to do |format|
      if @payment_module.update(payment_module_params)
        if params[:payment_module][:active]=='true'
          format.html { redirect_to payment_modules_edit_path, notice: 'Payment Module was successfully Activated!!.'}
          format.json { render :show, status: :ok, location: @payment_module }
        else
          format.html { redirect_to payment_modules_edit_path, notice: 'Payment Module was successfully De-Activated!!.'}
          format.json { render :show, status: :ok, location: @payment_module }
        end
      else
        format.html { render :edit }
        format.json { render json: @payment_module.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_module
      @payment_module = PaymentModule.first
    end

    def payment_module_params
      params.require(:payment_module).permit(:active)
    end

end
