class PartsController < ApplicationController

def status
  @parts = Part.all
  render :layout => false
end

end
