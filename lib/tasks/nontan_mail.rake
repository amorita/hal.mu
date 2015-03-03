namespace :nontan_mail do
  desc "Send mail of the 3A system"
  task :send => :environment do
    NontanMail.notification.deliver
  end
end
