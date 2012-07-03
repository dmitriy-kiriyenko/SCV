**"SCV ready to go, sir!"** -- *some scv*.

A set of thor scripts with most general tasks to administer Rails applications.

## Installation ##

Into Gemfile:

```ruby
gem 'scv', :group => 'development', :require => false
```

## Usage ##

### scv config ###

It's a common pattern, especially for open source projects not to keep development configuration files in version control, keeping their example versions instead. The most common is config/database.yml.example. While I'm going to support this patten in future, I currently suggest another one, which is keeping all example configuration files in config/examples, which structure repeats config directory. For support of this patter there is a setup:config script in this set. Run

```console
scv config
```

to copy all example configuration files to their natural locations. You may use `--force`, `--skip`, `--quiet` and `--pretend` options as with usual Rails generators. If you append any of the file names with `.tt` it will be considered as template, evaluated and placed to the right place without `.tt`.

### scv db ###

Pretty often you need to create a database, tune it's schema to current and load seeds after checking out a new application. I advice you to use a

```console
scv db
```

for it. Available modificators are:

* `--drop` or `-d` - drop database before creation. Defaults to false.
* `--no-seeds` - don't run `db:seed`

The `no-` options are also available with `--skip` prefix as usual (e.g., `--skip-test-clone`)

### scv populate ###

Again, pretty often you need to populate database with a test data, needed for development. I suggest a solution when near `db/seeds.rb` file you place `db/populate.rb` with the similar purpose and content, but containing data you'd like to insert to database for development. If you do so, you may use

```console
scv populate
```

to clean the database, load `seeds.rb` and `populate.rb` without dropping the database. There is an option `--no-truncate` to prevent database cleanup, that is used from meta tasks like `bootstrap` or `reset`.

### scv bootstrap ###

`scv bootstrap` should be used after initial checkout of application. It does `scv config --force`, then `scv db --no-seed` (because `scv populate` is expected to be run), and then, yeah, `scv populate --no-truncate`.

### scv reset ###

In the meantime, `scv reset` should be used when you wish to reset your database. It does `scv db --drop --no-seed`, then `scv populate --no-truncate`. This command can also be executed by just running `scv db`.

## How it looks ##

[![Space Construction Vehicle](http://i.minus.com/iXECZqiT0Ab7h.jpeg)](http://eu.battle.net/sc2/en/game/unit/scv)
