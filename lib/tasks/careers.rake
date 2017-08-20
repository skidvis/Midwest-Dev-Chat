namespace :careers do
  desc "purges old job entries"

  task update_jobs: :environment do
    Job.where('post_date < ?', DateTime.now-30.days).destroy_all
  end

  task post_to_slack: :environment do
    job_count = Job.where(post_date: DateTime.now-1.days)

    if job_count > 0          
      options = {
        :body => {
            :channel => "#apitest", 
            :username => "midwestdevchat.com", 
            :text => "#{job_count} new job(s) posted yesterday. <https://midwestdevchat.com/careers/all_jobs|Click Here> to see them."
        }.to_json
      }

      response = HTTParty.post("https://hooks.slack.com/services/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", options)      
    end
  end
end