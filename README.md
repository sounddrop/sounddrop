

## System Setup

* Follow these instruction only for creating the droplet https://www.digitalocean.com/community/tutorials/how-to-use-the-1-click-ruby-on-rails-on-ubuntu-14-04-image

* Added ssh keys
* login and install git: `apt-get install git`
* Remove the sample app `rm -Rf /home/rails`
* Clone `cd /home; git clone git@github.com:cloudyMBC/soundanchor.git rails`
* `chown -R rails:www-data .`
* Restart server `service unicorn restart`


## Deployment

* `git push`
* `ssh-add`
* `ssh root@178.62.207.114`
* `cd /home/rails`
* `git pull`
* TODO: run asset pipeline to generate public/images and stuff
* `chown -R rails:www-data .`
* `service unicorn restart`
