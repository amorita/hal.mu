namespace :ofx_import do
  desc "Import OSX File"
  task :execute => :environment do
    AccountTransactionsController.download_import
  end
end
