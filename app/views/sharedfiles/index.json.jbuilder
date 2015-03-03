json.array!(@sharedfiles) do |sharedfile|
  json.extract! sharedfile, :id, :filepath, :description, :category, :uploader, :name
  json.url sharedfile_url(sharedfile, format: :json)
end
