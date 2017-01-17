namespace :onetime do
  desc 'Set permalink for exist activities'
  task set_permalink_for_exist_activities: :environment do
    Activity.initialize_permalink
  end

  desc 'Set username from Github for users that have no username'
  task update_github_username: :environment do
    User.update_github_username
  end

  desc 'Merge duplicated user (by provider and uid)'
  task merge_user: :environment do
    User.all.group_by{|u| [u.provider,u.uid]}.each do |key, users|
      # use user instance that have oldest user_id as primary user
      users.sort_by!(&:id)
      primary_user = users.shift
      # transfer other users' paper to primary user
      users.each do |other_user|
        other_user.papers.each do |paper|
          paper.user = primary_user
          paper.save
        end
        other_user.destroy
      end
    end
  end
end
