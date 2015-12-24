module GoogleGmailApi
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'
  require 'google/api_client/auth/storage'
  require 'google/api_client/auth/storages/file_store'
  require 'fileutils'

  require 'base64'

  APPLICATION_NAME = 'Groups Settings API Ruby Quickstart'
  CLIENT_SECRETS_PATH = File.join(Dir.home, 'info.json')
  CREDENTIALS_PATH = File.join(Dir.home, 
                               "info_credenrial.json")
  SCOPE = 'https://www.googleapis.com/auth/gmail.readonly'

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

  def get_message_list(id)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('gmail', 'v1')
    p = {:userId => 'me', :includeSpamTrash => true, :labelIds => ['Label_14'], :q => 'to:' + id + '*'}
    m = api.users.messages.list
    list = client.execute(:api_method => m, 
      :parameters => p,
    :headers => {'Content-Type' => 'application/json'})
    list.data.to_hash
  end

  def get_message(id)
    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    client.authorization = authorize
    api = client.discovered_api('gmail', 'v1')
    p = {:userId => 'me', :id => id}
    m = api.users.messages.get
    message = client.execute(:api_method => m, 
      :parameters => p,
    :headers => {'Content-Type' => 'application/json'})
    m = message.data.to_hash

    mail = {}
    mail['body'] = Base64.urlsafe_decode64(m['payload']['parts'][0]['body']['data']).force_encoding('UTF-8').encode
    headers = m['payload']['headers']

    mail['subject'] = filterTag headers, 'Subject'
    mail['date'] = filterTag headers, 'Date'
    mail['from'] = filterTag headers, 'From'

    return mail
  end

  def filterTag(array, tag)
    array.each do |a|
      if a['name'] == tag then
        return a['value']
      end
    end
    return nil
  end

end