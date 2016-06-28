class InstagramController < ApplicationController

def index
  access_token = ConstantValue.where(:key => 'instagram_access_token').first.value
  url = 'https://api.instagram.com/v1/users/self/media/recent?access_token=' + access_token
  @posts = JSON.load(`curl #{url}`)
end

end
