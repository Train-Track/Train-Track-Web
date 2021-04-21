Train-Track-Web
===============

### Install

- Create a droplet on Digital Ocean using the Ruby on Rails application image
- Login with the root password e-mailed to you

    ```
    su - rails
    rvm install 2.6.5
    rvm use 2.6.5 --default
    ssh-keygen -t rsa -b 4096 -C "hello@traintrackapp.co.uk"
    ```

- Add the public key generated to the repository deploy keys and deploy the app

    ```
    git clone git@github.com:Train-TrackTrain-Track-Web.git train-track-web
    cd train-track-web
    bundle install
    ```

- Setup the secrets in config/secrets.yml:

    ```
    cp config/secrets.yml.example config/secrets.yml
    vi config/secrets.yml
    exit
    ```

- Set up the database and asset pipeline
    ```
    su - rails
    cd train-track-web
    rake db:create RAILS_ENV=production
    rake db:migrate RAILS_ENV=production
    rake assets:precompile RAILS_ENV=production
    exit
    ```
- Configure and restart rails server:
    ```
    vi /etc/systemd/system/rails.service
    Update example to train-track-web
    systemctl daemon-reload
    service rails restart
    ```

- Configure and reload nginx:
    ```
    vi /etc/nginx/sites-enabled/rails
    Update root /home/rails/train-track-web/public;
    service nginx reload
    ```

### Update app
```
su - rails
cd train-track-web
git pull
bundle install
rake db:migrate RAILS_ENV=production
rake assets:precompile RAILS_ENV=production
service rails restart
```

### Contribute
Please feel free to make pull requests!
