# envconfig

Easily configure your Ruby / Rails app to use the backing services specified in
environment variables such as those provided by [Broadstack][broadstack] or
[Heroku][heroku_addons] add-ons.

This lets you easily switch between providers, or between development and production,
without having configuration conditionals in your code.

For more on why this makes a lot of sense, read the [Config][12config] and
[Backing Services][12bs] sections of the excellent [Twelve-Factor App][12factor]
written by Heroku co-founder Adam Wiggins.


## Services and Providers

* [Database](#database): generic `DATABASE_URL`.
* [memcached](#memcached): MemCachier.
* [MongoDB](#mongodb): MongoHQ, MongoLab.
* [Redis](#redis): openredis, RedisCloud, RedisGreen, Redis To Go.
* [SMTP](#smtp): generic, Mailgun, Mandrill, Postmark, Sendgrid.


## Examples

Given the following ENV vars:

```sh
POSTMARK_SMTP_SERVER="smtp.example.org"
POSTMARK_API_KEY="bcca0a78abbaed6533f3c8017b804bda"
MONGOHQ_URL="mongodb://user:pass@mongo.example.com:2468/stack618"
```

Envconfig will look like this:

```ruby
config = Envconfig.load

# Individual keys:
config.smtp[:address] # => "smtp.example.org"
config.mongodb[:host] # => "mongo.example.com"

# Service configuration:
config.smtp.to_h # => {
  port: "25",
  authentication: :plain,
  address: "smtp.example.org",
  user_name: "bcca0a78abbaed6533f3c8017b804bda",
  password: "bcca0a78abbaed6533f3c8017b804bda"
}
config.mongodb.to_h # => {
  url: "mongodb://user:pass@mongo.example.com:2468/stack618",
  database: "stack618",
  username: "user",
  password: "pass",
  host: "mongo.example.com",
  port: 2468
}
```

And if you're using Rails, ActionMailer will be automatically configured
to use those SMTP details via `Rails.application.config.action_mailer.smtp_settings`.


## Installation

Add `gem "envconfig"` to your Gemfile and run `bundle`,
or `gem install envconfig`.

[![Build Status](https://travis-ci.org/broadstack/envconfig.png?branch=master)](https://travis-ci.org/broadstack/envconfig)

## Usage

### envconfig

The `envconfig` gem exposes your `ENV` configuration as a consistent interface,
using its knowledge of many add-on providers.

```ruby
Envconfig.load.smtp[:address]  => "example.org"
Envconfig.load.smtp.to_h  # => {address: "example.org", ...}
```

### envconfig-rails

The `envconfig-rails` gem adds Rails integration, pushing certain configuration
into the Rails application where it makes sense. Currently this is limited to
configuring ActionMailer for SMTP; feel free to open issues discussing others.


## Supported Add-ons

### Database

* Generic (`DATABASE_URL` in `ENV`)

Database example:

```ruby
ENV["DATABASE_URL"] = "postgres://ab:secret@example.org:1234/db?encoding=utf-8"

Envconfig.load.database.to_h # =>
{
  url: "postgres://ab:secret@example.org:1234/db?encoding=utf-8",
  adapter: "postgresql",
  database: "db",
  username: "ab",
  password: "secret",
  host: "example.org",
  port: 1234,
  encoding: "utf-8"
}


```


### SMTP

* Postmark ([Broadstack](https://broadstack.com/addons/postmark), [Heroku](https://addons.heroku.com/postmark))
* Mandrill ([Heroku](https://addons.heroku.com/mandrill))
* SendGrid ([Heroku](https://addons.heroku.com/sendgrid))
* Mailgun ([Heroku](https://address.Heroku.com/mailgun))
* Generic (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD` in `ENV`)

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


### MongoDB

* MongoHQ ([Broadstack](https://broadstack.com/addons/mongohq), [Heroku](https://addons.heroku.com/mongohq))
* MongoLab ([Heroku](https://addons.heroku.com/mongolab))

MongoDB example:

```ruby
ENV["MONGOHQ_URL"] = "mongodb://user:pass@mhq.example.org:2468/stack618"

Envconfig.load.mongodb.to_h # =>
{
  url: "mongodb://user:secret@mhq.example.org:2468/stack618",
  username: "user",
  password: "secret",
  host: "mhq.example.org",
  port: 2468,
  database: "stack618"
}
```


### Redis

* openredis ([Heroku](https://addons.heroku.com/openredis))
* RedisCloud ([Heroku](https://addons.heroku.com/rediscloud))
* RedisGreen ([Heroku](https://addons.heroku.com/redisgreen))
* Redis To Go ([Heroku](https://addons.heroku.com/redistogo))

Redis example:

```ruby
ENV["OPENREDIS_URL"] = "redis://:secrettoken@127.0.0.1:6379"

Envconfig.load.redis.to_h # =>
{
  url: "redis://:secrettoken@127.0.0.1:6379",
  host: "127.0.0.1",
  port: 6379,
  user: "",
  password: "secrettoken",
}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[backing_services]: http://12factor.net/backing-services
[broadstack]: https://broadstack.com
[heroku_addons]: https://addons.heroku.com/
[12factor]: http://12factor.net/
[12config]: http://12factor.net/config
[12bs]: http://12factor.net/backing-services
