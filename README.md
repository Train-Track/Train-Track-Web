Train-Track-Web
===============

To Deploy:

- Create a droplet on Digital Ocean using the Ruby on Rails application image
- Login with the root password e-mailed to you

    apt-get install git
    git config --global user.name "Your Name"
    git config --global user.email "your_email@example.com"
    ssh-keygen -t rsa -C "your_email@example.com"

- Add the public key generated to your Github Profile

    git clone git@github.com:Train-Track/Train-Track-Web.git /home/rails/trains
    su - rails
    cd /home/rails/trains
    chown -R rails .
    chgrp -R www-data .
    bundle install
    exit

- Create the database user:

    su - postgres
    psql
    create role trains with createdb login password 'password';
    \q
    exit

- Set the secrets in config/secrets.yml.example and rename:

    su - rails
    cd trains/
    cp config/secrets.yml.example config/secrets.yml
    vi config/secrets.yml.example

- Set up the database and asset pipeline

    rake db:create RAILS_ENV=production
    rake db:migrate RAILS_ENV=production
    rake assets:precompile RAILS_ENV=production
    exit

- Configure and restart unicorn:

    vi /etc/unicorn.conf
    working_directory "/home/rails/trains"
    cp /home/rails/rails_project/.unicorn.sh /home/rails/trains/
    chmod 755 /home/rails/trains/.unicorn.sh
    vi /home/rails/trains/.unicorn.sh
    Update rails_project to trains
    vi /etc/systemd/system/unicorn.service
    Update rails_project to trains
    systemctl daemon-reload
    service unicorn restart

- Configure and reload nginx:

    vi /etc/nginx/sites-enabled/rails
    root /home/rails/trains/public;
    service nginx reload

To Update:
    cd /home/rails/trains
    git pull
    rake db:migrate RAILS_ENV=production
    rake assets:precompile RAILS_ENV=production
    service unicorn restart


To Contribute:

Please feel free to make pull requests!
