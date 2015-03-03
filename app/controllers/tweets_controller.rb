class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.get_latest.as_json
  end  
  
end
