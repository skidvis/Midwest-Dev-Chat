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
  title: 'Midwest Dev Chat'
  secret_key_base: *secret_base*
  slack_domain: midwestdevchat
  slack_token: *token*
  slack_channel: *slack_channel*
  slack_webhook_url: *webhook_url*
  admin_email: *admin_email*
  sendgrid_user: *sendgrid_user*
  sendgrid_password: *sendgrid_password*
  restricted_channels:
  - *restricted_channel*
  - *restricted_channel*

test:
  secret_key_base: *secret_base*

production:
  title: 'Midwest Dev Chat'
  secret_key_base: *secret_base*
  slack_domain: midwestdevchat
  slack_token: *token*
  slack_channel: *slack_channel*
  slack_webhook_url: *webhook_url*
  admin_email:
  - *admin_email*
  - *admin_email*
  sendgrid_user: *sendgrid_email*
  sendgrid_password: *sendgrid_password*
  restricted_channels:
  - *restricted_channel*
  - *restricted_channel*
```

## That's it!

I hope I've given you enough info to get started. 
If you have any questions, feel free to reach out!

Thanks!
Vis

