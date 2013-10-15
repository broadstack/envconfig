# envconfig

Connect your Rails app to backing services via ENV vars such as those
provided by [Broadstack][broadstack] or [Heroku Addons][heroku_addons].

envconfig gathers ENV configuration from known add-on providers, exposes them
as a consistent configuration interface, and configures your Rails application
via initializers.

For example if your ENV contains the follow:

```
POSTMARK_SMTP_SERVER="smtp.example.org"
POSTMARK_API_KEY="bcca0a78abbaed6533f3c8017b804bda"
```

Then envconfig's SMTP configuration will look like this:

```ruby
Envconfig.load(ENV).smtp.to_h # =>
{
  "address" => "smtp.example.org",
  "port" => 25,
  "username" => "bcca0a78abbaed6533f3c8017b804bda",
  "password" => "bcca0a78abbaed6533f3c8017b804bda",
}
```

And `ActionMailer` will be auto-configured accordingly.


## Installation

Add `gem "envconfig"` to your Gemfile and run `bundle`,
or `gem install envconfig`.

[![Build Status](https://travis-ci.org/broadstack/envconfig.png?branch=master)](https://travis-ci.org/broadstack/envconfig)

## Usage

Add `envconfig-rails` to your `Gemfile` and go.

If you're not using Rails, add the base `envconfig` gem, and access the
normalized configuration directly.


## Supported Add-ons

### SMTP

* Postmark ([Broadstack](https://broadstack.com/addons/postmark), [Heroku](https://addons.heroku.com/postmark))
* Mandrill ([Heroku](https://addons.heroku.com/mandrill))
* SendGrid ([Heroku](https://addons.heroku.com/sendgrid))
* Custom (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD` in `ENV`)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[backing_services]: http://12factor.net/backing-services
[broadstack]: https://broadstack.com
[heroku_addons]: https://addons.heroku.com/
