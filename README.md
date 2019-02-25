== README

This is CFP App for [Ruby Conf Taiwan](http://rubyconf.tw).

###Necessary Program

-	PostgreSQL 9.3+
-	Redis (for Sidekiq / ActiveJob)

###Before Run:

-	Setup database.yml
-	cp config/application.yml.example config/application.yml

###Running Tests

-	Create Test DB
-	rake spec
