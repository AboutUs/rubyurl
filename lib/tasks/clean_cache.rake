desc "Clean page cached files in the public folder"
task :clean_cache => :environment do
  FileUtils.rm_rf "#{Rails.root}/public/about.html"
  FileUtils.rm_rf "#{Rails.root}/public/api.html"
  FileUtils.rm_rf "#{Rails.root}/public/home.html"
  FileUtils.rm_rf "#{Rails.root}/public/report-abuse.html"
end