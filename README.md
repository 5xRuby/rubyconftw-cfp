== README

This is CFP App for [Ruby X Elixir Conf Taiwan](http://rubyconf.tw) contributed by [members](https://github.com/5xRuby/rubyconftw-cfp/graphs/contributors) of [5xRuby](http://5xruby.tw).

###Necessary Program

-	PostgreSQL 9.3+
-	Redis (for Sidekiq / ActiveJob)

###Before Run:

-	Setup database.yml
-	cp config/application.yml.example config/application.yml

###Running Tests

-	Create Test DB
-	rake spec
