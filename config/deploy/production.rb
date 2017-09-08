set :default_env, { path: "$PATH:/usr/local/ruby-2.4.1/bin:" }
set :deploy_to, '/home/deploy/rubyconf-cfp'
role :app, %w{deploy@10.128.128.154}
role :web, %w{deploy@10.128.128.154}
role :db,  %w{deploy@10.128.128.154}