set :default_env, { path: "$PATH:/usr/local/ruby-2.3.6/bin:" }
set :deploy_to, '/home/deploy/rubyconf-cfp'
role :app, %w{deploy@do.5xruby.tw}
role :web, %w{deploy@do.5xruby.tw}
role :db,  %w{deploy@do.5xruby.tw}
