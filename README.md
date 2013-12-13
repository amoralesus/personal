Overview
==========

This is a sample Rails4 app that uses Heroku as the production environment, it uses
rspec for testing and haml for the views.

The sample app keeps track of keychains. The keychains are encrypted in the
db and the admin user is notified anytime a key is shown.

### Configuration - Heroku

To run this app in Heroku, you need to:
* Setup your account with Heroku
* Install their CLI client for your dev machine

Then, from the root directory of the app, in the command line type:

```
$ bundle install --without production (no need for you to setup postgres on your dev machine)
$ heroku login
$ heroku create you_app_name_here
$ git push heroku master
$ heroku run db:migrate
```

### Configuration - Environment Variables

For this app to run you will need the following environment variables setup.

* `CONFIG_KEY=some_key_used_to_encrypt_keychains`
* `CONFIG_SALT=some_salt_used_to_encrypt_keychains`
* `CONFIG_SECRET_KEY_BASE=some_other_key_needed_for_rails_cookie`
* `smtp_user=your_gmail_username_used_to_send_emails_from_app`
* `smtp_password=your_gmail_password`
* `smtp_domain=your_gmail_domain_or_smtp.gmail.com`
* `heroku_app_name=mykeychainapp.heroku.com (used when sending emails)`
* `admin_eamil=someadmin@gmail.com (used when sending the notification)`

To setup the environment variables in development add them to your `.bash_profile` file
in your home directory like this:

```
export CONFIG_KEY=some_key_used_to_encrypt_keychains
...
```

To setup the environment variables in heroku, you need to have created the app in heroku first.
Go to the root directory of your app and enter:

```
$ heroku config:set CONFIG_KEY=some_key_used_to_encrypt_keychains
...
```






