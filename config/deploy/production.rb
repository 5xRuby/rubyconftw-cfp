set :deploy_to, '/home/rubytw/rubyconf.tw/cfp'
role :app, %w{rubytw@cfp.rubyconf.tw:14159}
role :web, %w{rubytw@cfp.rubyconf.tw:14159}
role :db,  %w{rubytw@cfp.rubyconf.tw:14159}