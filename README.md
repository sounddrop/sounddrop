

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
* `./deploy.sh`


## Debugging server problems

Look at the Rails logs 
```
cd /home/rails
tail -100 log/production.log
```

or look at the unicorn logs for startup problems or bundle errors

```
tail -100 /home/unicorn/log/unicorn.log
```


