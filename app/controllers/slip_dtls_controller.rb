class SlipDtlsController < ApplicationController
  layout 'priv'
  respond_to :html
  before_filter :authenticate_user!

  def index
    @year = params[:year]
    @month = params[:month]
    @slip_dtls = []
    unless @year.nil? && @month.nil?
      @slip_dtls = SlipDtl.where("trans_date >= '#{@year}/#{@month}/01'").where("trans_date < DATE_ADD('#{@year}/#{@month}/01', INTERVAL 1 MONTH)").order(:trans_date)
    end
    @years = []
    5.times do |i|
      node = []
      node << Date.today.year - i
      node << Date.today.year - i
      @years << node
    end
    @months = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8], [9, 9], [10, 10], [11, 11], [12, 12]]
  end
end
