class PartController < ApplicationController

def status
  @parts = Part.all
end

end
