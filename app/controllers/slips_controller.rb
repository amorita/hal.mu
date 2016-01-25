class SlipsController < ApplicationController
  before_action :set_slip, only: [:show, :edit, :update, :destroy]
  layout 'priv'
  respond_to :html
  before_filter :authenticate_user!

  def index
    if view_context.is_granted :accountant
      @slips = Slip.all.order("id DESC")
    else
      @slips = Slip.where(:user_id => current_user).order("id DESC")
    end
    respond_with(@slips)
  end

  def show
    respond_with(@slip)
  end

  def new
    @is_new = true
    @slip = Slip.new
    @slip.slip_dtls.build
    @slip.vouchers.build
    @slip.created_at = Time.now
    @slip.user_id = current_user.id
    respond_with(@slip)
  end

  def edit
    @is_new = false
  end

  def create
    @slip = Slip.new(slip_params)
    @slip.vouchers.each_with_index do |v, idx|
      file = slip_params[:vouchers_attributes][idx.to_s.to_sym][:file_path]
      ext = File.extname(file.original_filename)
      filename = Date.today().day.to_s + '-' + SecureRandom.hex(16) + ext
      dir = Date.today().year.to_s + '/' + Date.today().month.to_s
      `mkdir /home/yu/rails/hal.mu/public/vouchers/#{dir} -p`
      File.open("/home/yu/rails/hal.mu/public/vouchers/#{dir}/#{filename}", 'wb') { |f|
        f.write(file.read)
      }
      v.file_path = "#{dir}/#{filename}"
    end
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
        slip_dtls_attributes: [:id, :slip_id, :amount, :accounting_item_id, :memo, :trans_date, :_destroy],
        vouchers_attributes: [:id, :slip_id, :file_path, :file]
      )
    end
end
