class ZipCodesController < ApplicationController

  def show
    render text: ZipCode.get_address(params[:id])
  end

end
