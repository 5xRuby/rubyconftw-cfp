set :default_env, { path: "/usr/local/ruby27/bin:$PATH:" }
set :deploy_to, '/home/deploy/rubyconf-cfp'
role :app, %w{deploy@do.5xruby.com}
role :web, %w{deploy@do.5xruby.com}
role :db,  %w{deploy@do.5xruby.com}
