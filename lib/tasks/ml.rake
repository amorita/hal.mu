namespace :ml do
  desc "Refresh ML member list"
  task :refresh => :environment do
    PersonalDataController.new.update_all_ml
  end
end
