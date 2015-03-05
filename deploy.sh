#!/bin/bash

ssh-add
ssh -A root@sounddrop.audio <<END
cd /home/rails
git pull
bundle install --deployment
chown -R rails:www-data .
service unicorn restart
END
