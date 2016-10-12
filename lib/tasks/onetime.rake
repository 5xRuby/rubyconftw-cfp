namespace :onetime do
  desc 'Set permalink for exist activities'
  task set_permalink_for_exist_activities: :environment do
    Activity.initialize_permalink
  end

  desc 'Set username from Github for users that have no username'
  task update_github_username: :environment do
    User.update_github_username
  end
end
