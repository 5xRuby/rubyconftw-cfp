set :deploy_to, '/home/rubytw/staging-apps/cfp-stg.rubyconf.tw'
role :app, %w{rubytw@cfp.rubyconf.tw:14159}
role :web, %w{rubytw@cfp.rubyconf.tw:14159}
role :db,  %w{rubytw@cfp.rubyconf.tw:14159}