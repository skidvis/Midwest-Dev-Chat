[![Stories in Ready](https://badge.waffle.io/skidvis/Midwest-Dev-Chat.png?label=ready&title=Ready)](https://waffle.io/skidvis/Midwest-Dev-Chat)
# What is this?
Midwest Dev Chat is an awesome group of developers (software, web, etc) from the midwest who hang out daily using the great Slack messaging app. 

Joining the chat group requires an invite from an admin. There's quite a few of us, but if you don't know who to ask then it makes joining a bit harder.
Another thing I've been asked a few times is, "Is there a feed of the chats we can see on the web?"

Those two reasons are why I thought about putting this together. It provides a central website where someone can go to take a quick look at what's happening in the #generalchat channel (there's quite a few channels for different technogies, music, meetups, etc) and also request an invite directly. 

# How can you help?
I made this in a day, I'm not very good at Ruby/Rails, I'm not the best designer on Earth. 
I'm fairly certain there's better ways of handling some of the features I added, and that there are features I haven't even considered which would be awesome. 
If you have the skills to improve or add features, please help us out!

# Gotchas
Two files are missing from this repo. The database.yml and secrets.yml from the config folder.
They have, um.. secrets, so I didn't think it would be wise to check them in. 

This is what they look like, but the identities have been changed to protect the innocent

## database.yml
```ruby
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  database: midwestdevchat_development

test:
  <<: *default
  database: midwestdevchat_test

production:
  <<: *default
  database: midwestdevchat_production
  username: midwestdevchat_user
  password: ''
```

## secrets.yml
```ruby
development:
  title: # the name of the site
  secret_key_base: # all about that base.
  slack_token: # api access token from slack
  slack_channel: C02GHRETZ # the slack id for the #general channel 
  admin_email: # the email address of an admin who will get notified of a new member request
  sendgrid_user: # sendgrid username
  sendgrid_password: # sendgrid password
  restricted_channels:
  - # array items
  - # of restricted channels
  - # by channel.name

test:
  secret_key_base: # all your base are belong to us, for tests.

production:
  title: # the name of the site
  secret_key_base: # I'm rob base and I came to get down, to business.
  slack_token: # api access token from slack
  slack_channel: C02GHRETZ # the slack id for the #general channel 
  admin_email: # the email address of an admin who will get notified of a new member request
  sendgrid_user: # sendgrid username
  sendgrid_password: # sendgrid password
  restricted_channels:
  - # array items
  - # of restricted channels
  - # by channel.name
```

## That's it!

I hope I've given you enough info to get started. 
If you have any questions, feel free to reach out!

Thanks!
Vis

