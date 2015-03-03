require 'grackle'

class Tweet < ActiveRecord::Base

  MY_SCREEN_NAME = 'OrchestraHAL'

  def self.get_latest
    tweets = client.statuses.user_timeline? screen_name: MY_SCREEN_NAME, trim_user: true

  end

  private
  def self.client
    Grackle::Client.new(:auth=>{
      type: :oauth,
      consumer_key: 'T6Srt94gq9aiEJ9ydaw',
      consumer_secret: 'NsFg5CZfNoJDAb3HIxCOroDNeMCnuDwXTOfNeOQswo',
      token: '356488650-evJbUKXOkwfJFWpDjCQlImsIttLvmmhaYCiJyQTV',
      token_secret: 'Ll3y90Va0fzUv8jcqHvDgduox7r858b7b23jj4YXt7E'
                        })

  end
end
