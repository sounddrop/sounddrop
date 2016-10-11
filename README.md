[![Build Status](https://travis-ci.org/sounddrop/sounddrop.svg?branch=master)](https://travis-ci.org/sounddrop/sounddrop)

This is the repository for SoundDrop. <a href="http://sounddrop.audio">Read about and view SoundDrop here.</a>

## How to run locally

Prerequisites:

* ruby 2.2.2
* mysql libraries. If you are using a mac, do `brew install mysql`

Install bundler and run bundle install:

```
gem install bundler
bundle install
```
Setup the development database:

```
rake db:setup
```
We use [foreman](https://github.com/ddollar/foreman) to get the app running. Make sure you've done bundle install so that you have forman available. Then run:

```
foreman start dev
```

If this doesn't work, clear your cookies. It could solve the problem.

See a SoundDrop: http://localhost:3000/drops/187471639

## How to run tests

Setup test database

For bash:
````
RAILS_ENV=test rake db:setup
bundle exec rspec
````
For fish
````
env RAILS_ENV=test rake db:setup
bundle exec rspec
````

## Contribution

Small fixes can be pushed straight to master. For new features, please drop a line to sounddrop@googlegroups.com

Please
* ensure master build is always passing (run your tests locally before pushing to master)
* ensure master is always what is deployed (deploy your change to master)

By contributing, you agree to adhere to our [Code of Conduct](https://github.com/sounddrop/sounddrop/blob/master/CODE_OF_CONDUCT.md).

## Deployment

* `git push`
* `./deploy.sh`


## Debugging server problems in production


Look at the Rails logs
```
cd /home/rails
tail -100 log/production.log
```

or look at the unicorn logs for startup problems or bundle errors

```
tail -100 /home/unicorn/log/unicorn.log
```

Restart server `service unicorn restart`

##

* Follow these instructions only for [creating the Droplet][droplet]

[droplet]: https://www.digitalocean.com/community/tutorials/how-to-use-the-1-click-ruby-on-rails-on-ubuntu-14-04-image

* Added ssh keys
* login and install git: `apt-get install git`
* Remove the sample app `rm -Rf /home/rails`
* Clone `cd /home; git clone git@github.com:sounddrop/sounddrop.git rails`
* `chown -R rails:www-data .`


## Developer Tool: API Explorer

To discover the SoundDrop API, follow this link that will allow you to enter different endpoints to see which response you will get:

[API Explorer]: http://Sounddrop.audio/explorer
