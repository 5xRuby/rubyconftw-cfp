set :default_env, { path: "$PATH:/usr/local/ruby27/bin:" }
set :deploy_to, '/home/deploy/rubyconf-cfp'
role :app, %w{deploy@do.5xruby.com}
role :web, %w{deploy@do.5xruby.com}
role :db,  %w{deploy@do.5xruby.com}