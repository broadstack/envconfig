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
Envconfig.load.smtp.to_h # =>
{
  port: "25",
  authentication: :plain,
  address: "smtp.example.org",
  user_name: "bcca0a78abbaed6533f3c8017b804bda",
  password: "bcca0a78abbaed6533f3c8017b804bda"
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
configuration like this:

```ruby
Envconfig.load.smtp[:address]  => "example.org"
Envconfig.load.smtp.to_h  # => {address: "example.org", ...}
```


## Supported Add-ons

### SMTP

* Postmark ([Broadstack](https://broadstack.com/addons/postmark), [Heroku](https://addons.heroku.com/postmark))
* Mandrill ([Heroku](https://addons.heroku.com/mandrill))
* SendGrid ([Heroku](https://addons.heroku.com/sendgrid))
* Custom (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD` in `ENV`)

SMTP example:

```ruby
ENV["MANDRILL_USERNAME"] = "mandrilluser"
ENV["MANDRILL_APIKEY"] = SecureRandom.hex

Envconfig.load.smtp.to_h # =>
{
  address: "smtp.mandrillapp.com",
  port: "587",
  user_name: "mandrilluser",
  password: "14941007dfdc2af76e2fafe1383cf33b"
}
```

### memcached

* MemCachier ([Broadstack](https://broadstack.com/addons/memcachier), [Heroku](https://addons.heroku.com/memcachier))

memcached example:

```ruby
ENV["MEMCACHIER_SERVERS"] = "a.example.org:11211,b.example.com:11211"
ENV["MEMCACHIER_USERNAME"] = "memcachieruser"
ENV["MEMCACHIER_PASSWORD"] = SecureRandom.hex

Envconfig.load.memcached.to_h # =>
{
  servers: "a.example.org:11211,b.example.com:11211",
  username: "memcachieruser",
  password: "9d1d72d6828ed59bab3d1496da71ba59",
  server_strings: ["a.example.org:11211", "b.example.com:11211"]
}
```


### Redis

(none yet)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[backing_services]: http://12factor.net/backing-services
[broadstack]: https://broadstack.com
[heroku_addons]: https://addons.heroku.com/
