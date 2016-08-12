#!/bin/bash


ssh-add
ssh -A root@sounddrop.audio <<END

set -e -x
cd /home/rails
git pull
bundle install --deployment
chown -R rails:www-data .
service unicorn stop
bundle exec rake assets:precompile
bundle exec rake db:migrate
service unicorn start
END
