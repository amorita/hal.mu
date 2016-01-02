class MlsController < ApplicationController

  include GoogleDirectoryApi
  include GoogleGmailApi

  layout 'priv'

  def index
    @ml_list = get_mls(current_user)
  end

  def show
    page_token = params[:pages]
    id = params[:id]
    id_list = []
    id_list << id
    @ml = get_ml_list(id_list)[0]
    @list = get_message_list(id, page_token)
    @messages = []
    @list['messages'].each do |m|
      @messages << get_message(m['id']) unless m.nil?
    end
    @is_first = true
    if page_token.empty?
      @is_first = false
    end
  end

  def get_mls(user)
    list = []
    list << 'ml'
    list << user.part.abbr
    case user.part_id
    when 1,2,3,4 then
      list << 'strings'
    when 105, 106, 107, 108
      list << 'woods'
      list << 'winds'
    when 109, 110, 111, 112, 113
      list << 'brasses'
      list << 'winds'
    end
    if user.admin_member
      list << 'admins'
    end
    get_ml_list list
  end

end
