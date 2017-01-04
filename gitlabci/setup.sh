apk add --no-cache tzdata build-base imagemagick-dev libev pkgconfig postgresql  postgresql-dev postgresql-client bash nodejs git
bundle check --path=${BUNDLE_CACHE} || bundle install --path=${BUNDLE_CACHE} --jobs=2 --retry=3
bundle exec rake db:create
bundle exec rake db:migrate:reset