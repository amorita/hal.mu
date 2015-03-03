class Sharedfile < ActiveRecord::Base
  def file
    @file || nil
  end
end
