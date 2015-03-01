Train-Track-Web
===============

To Deploy:

- Sign up to Web Faction
- Create a rails application
- Create the database
- Clone this repo into the application folder
- Set up environment variables

    bundle install
    rake db:migrate RAILS_ENV=production
    rake assets:precompile

- Restart the nginx server with config pointing to this app


To Contribute:

Please feel free to make pull requests!
