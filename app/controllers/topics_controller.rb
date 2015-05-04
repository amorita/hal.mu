class TopicsController < ApplicationController

def index
  @topics = Topic.all.order("created_at desc").limit 5
  render :partial => "index"
end

end
