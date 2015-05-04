class Sharedfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :file_category
  def file
    @file || nil
  end
end
