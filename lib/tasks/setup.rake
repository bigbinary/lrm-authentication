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
    john = User.create! email: "john@example.com", password: "welcome", name: "John Smith"

    Posts.create! user: john, title: "My First Post", content: "Welcome to my new Post"
    Posts.create! user: john, title: "A new day", content: "This is where I write about another technical discussions."
  end

  puts 'populating sample data is done'
end
