class SlipsController < ApplicationController
  before_action :set_slip, only: [:show, :edit, :update, :destroy]
  layout 'priv'
  respond_to :html

  def index
    @slips = Slip.all
    respond_with(@slips)
  end

  def show
    respond_with(@slip)
  end

  def new
    @slip = Slip.new
    @slip.slip_dtls.build
    @slip.vouchers.build
    @slip.created_at = Time.now
    @slip.user_id = current_user.id
    respond_with(@slip)
  end

  def edit
  end

  def create
    @slip = Slip.new(slip_params)
    @slip.save
    respond_with(@slip)
  end

  def update
    @slip.update(slip_params)
    respond_with(@slip)
  end

  def destroy
    @slip.destroy
    respond_with(@slip)
  end

  private
    def set_slip
      @slip = Slip.find(params[:id])
    end

    def slip_params
      params.require(:slip).permit(:user_id, :amount, :slip_dtl_id,
        slip_dtls_attributes: [:id, :amount, :accounting_item_id, :memo],
        vouchers_attributes: [:id, :slip_id, :file_path]
      )
    end
end
