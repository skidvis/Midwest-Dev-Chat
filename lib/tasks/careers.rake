namespace :careers do
  desc "purges old job entries"

  task update_jobs: :environment do
    Job.where('post_date < ?', DateTime.now-30.days).destroy_all
  end

end