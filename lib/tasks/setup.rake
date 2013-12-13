desc 'Populate data from db/data file'
task :setup => :environment do
  return if Rails.env.production?
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['setup_sample_data'].invoke
end

task setup_sample_data: :environment do
  User.delete_all

  User.transaction do
    User.create! email: "john@example.com", password: "welcome", name: "John Smith"
  end

  puts 'populating sample data is done'
end
