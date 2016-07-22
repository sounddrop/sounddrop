#!/bin/bash


ssh-add
ssh -A root@sounddrop.audio <<END

set -e -x
cd /home/rails
git pull
bundle install --deployment
chown -R rails:www-data .
bundle exec rake db:migrate
service unicorn restart

END
