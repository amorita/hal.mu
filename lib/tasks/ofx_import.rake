namespace :ofx_import do
  desc "Import OSX File"
  task :execute => :environment do
    DownloadOfx.execute
  end
end
