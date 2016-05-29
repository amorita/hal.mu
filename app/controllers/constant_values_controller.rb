class ConstantValuesController < ApplicationController
  layout false
  def plain
    key = params[:key]
    @value = ConstantValue.where(:key => key).first
  end

  def formatted
    key = params[:key]
    @value = ConstantValue.where(:key => key).first
  end
end
