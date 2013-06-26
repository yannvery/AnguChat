## AngularJS - Rails - Bootstrap

Testing AngularJS with a simple chat application

[AngularJS](http://angularjs.org/)

## HowTo

	git clone git@github.com:yannvery/AnguChat.git anguchat
	cd anguchat
	
	# ruby 2.0.0 needed
	
	gem install bundler
	
	bundle install
	rake db:migrate
	bundle exec rails s

Open web browser @ http://localhost:3000/

## Deploy on heroku

Heroku documentation is available here : https://devcenter.heroku.com/articles/rails4-getting-started

Short deploy :

1. heroku login
2. heroku create
3. git push heroku master

