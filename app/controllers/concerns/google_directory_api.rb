# -*- coding: utf-8 -*-
module GoogleDirectoryApi
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'
  require 'google/api_client/auth/storage'
  require 'google/api_client/auth/storages/file_store'
  require 'fileutils'

  APPLICATION_NAME = 'Groups Settings API Ruby Quickstart'
  CLIENT_SECRETS_PATH = File.join(Dir.home, 'client_secret.json')
  CREDENTIALS_PATH = File.join(Dir.home, 
                               "credenrial.json")
  SCOPE = ['https://www.googleapis.com/auth/apps.groups.settings','https://www.googleapis.com/auth/admin.directory.group.readonly','https://www.googleapis.com/auth/admin.directory.group']

  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization request via InstalledAppFlow.
  # If authorization is required, the user's default browser will be launched
  # to approve the request.
  #
  # @return [Signet::OAuth2::Client] OAuth2 credentials
  def authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
    storage = Google::APIClient::Storage.new(file_store)
    auth = storage.authorize

    if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
      app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
      flow = Google::APIClient::InstalledAppFlow.new({
        :client_id => app_info.client_id,
        :client_secret => app_info.client_secret,
        :scope => SCOPE})
      auth = flow.authorize(storage)
      puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
    end
    auth
  end

  def add_member(id, email)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    group_email = id + '@hal.mu'
    p = {:groupKey => group_email}
    b = {:email => email, :role => "MEMBER"}
    m = api.members.insert
    client.execute(:api_method => m, :parameters => p, :body_object => b)
  end

  def reflesh_members(id)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    group_email = id + '@hal.mu'
    list = get_memberlist(id)
    unless list.nil?
      list.each do |member|
        delete_member(id, member['id'])
      end
    end

    case id
    when 'admins' then
      users = User.where(:admin_member => true)
    when 'ml' then
      users = User.all
    when 'brasses' then
      users = User.where(:part_id => [109, 110, 111, 112, 113])
    when 'woods' then
      users = User.where(:part_id => [105, 106, 107, 108])
    when 'winds' then
      users = User.where(:part_id => [105, 106, 107, 108, 109, 110, 111, 112, 113])
    when 'strings' then
      users = User.where(:part_id => [1, 2, 3, 4])
    else
      part = Part.where(:abbr => id).first
      users = User.where(:part_id => part.id)
    end
    info = User.new
    info.email = 'info@hal.mu'
    users << info
    users.each do |user|
      add_member(id, user.email)
      unless user.email2.nil?
        add_member(id, user.email2)
      end
    end

    
  end

  def get_memberlist(id)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    group_email = id + '@hal.mu'
    p = {:groupKey => group_email}
    b = {}
    m = api.members.list
    list = client.execute(:api_method => m, :parameters => p)
    list.data.to_hash['members']
  end

  def get_ml_list(list)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    result = [ ]
    list.each do |l|
      p = {:domain => 'hal.mu', :groupKey => l + '@hal.mu'}
      b = {}
      m = api.groups.get
      res = client.execute(:api_method => m, :parameters => p)
      hash = res.data.to_hash
      hash['id'] = l
      result << hash
    end
    result
  end

  def delete_member(id, email)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    group_email = id + '@hal.mu'
    p = {:groupKey => group_email, :memberKey => email}
    m = api.members.delete
    client.execute(:api_method => m, :parameters => p)
  end

  def update_member(id, old_email, new_email)
    delete_member(id, old_email) unless old_email.nil?
    add_member(id, new_email) unless new_email.nil?
  end

  def get_grouplist
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('admin', 'directory_v1')
    p = {:domain => 'hal.mu'}
    b = {}
    m = api.groups.list
    list = client.execute(:api_method => m, :parameters => p)
    list.data.to_hash['groups']
  end

  def reflesh_all_groups
    list = get_grouplist
    list.each do |group|
      reflesh_members group['email'].sub(/@hal\.mu/, '') 
    end
  end

  def proc_ml(old_email, old_email2, personal_data)
    update_ml('ml', old_email, old_email2, personal_data)
    #パートに従った処理
    update_ml(personal_data.part.abbr, old_email, old_email2, personal_data)
    case personal_data.part_id
    when 1,2,3,4 then
      update_ml('strings', old_email, old_email2, personal_data)
    when 105, 106, 107, 108
      update_ml('woods', old_email, old_email2, personal_data)
      update_ml('winds', old_email, old_email2, personal_data)
    when 109, 110, 111, 112, 113
      update_ml('brasses', old_email, old_email2, personal_data)
      update_ml('winds', old_email, old_email2, personal_data)
    end

    if personal_data.admin_member
      update_ml('admins', old_email, old_email2, personal_data)
    end

  end

  def update_ml(mlId, old_email, old_email2, personal_data)
    unless old_email == personal_data.email then
      update_member(mlId, old_email, personal_data.email)
    end
    unless old_email2 == personal_data.email2 then
      update_member(mlId, old_email2, personal_data.email2)
    end
  end
end
