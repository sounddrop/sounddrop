#!/bin/bash

ssh-add
ssh -A root@178.62.207.114 <<END
cd /home/rails
git pull
bundle install --deployment
chown -R rails:www-data .
service unicorn restart
END
