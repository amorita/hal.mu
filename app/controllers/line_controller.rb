class LineController < ApplicationController

  before_filter :authenticate_user!

  require 'net/https'

  def auth
    code = params[:code]
    line = LineConnect.where(:user_id => current_user.id).first
    if line.nil?
      line = LineConnect.new
      line.user_id = current_user.id
    end
    line.code = code
    line.save!

    json = `curl -X POST -d grant_type=authorization_code \
      -d code=#{line.code} \
      --data-urlencode redirect_uri=http://localhost:3000/line/auth \
      -d client_id=#{ConstantValue.where(:key => 'line_client_id').first.value} \
      -d client_secret=#{ConstantValue.where(:key => 'line_client_secret').first.value} \
      https://notify-­bot.line.me/oauth/token`
    res = JSON.parse(json)
    line.access_token = res['access_token']
    line.save!

    `curl -X POST -H 'Authorization: Bearer #{line.access_token}' -F 'message=OrchestraHALとの連携に成功しました！' https://notify-api.line.me/api/notify`

    redirect_to controller: 'main', action: 'index', notice: 'LINEとの連携が成功しました！'
  end

end
