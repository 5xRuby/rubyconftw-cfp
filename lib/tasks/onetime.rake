namespace :onetime do
  desc 'Set permalink for exist activities'
  task set_permalink_for_exist_activities: :environment do
    Activity.initialize_permalink
  end
end
