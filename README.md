# Mousevc

	(`) (`)
	=('o')=
	  m m  

	MousevC
	V     L
	C     I

A tiny mouse sized MVC framework to jump start command line apps. Written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mousevc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mousevc

## Usage

1. Extend `Mousevc::App`

```ruby
# jerry.rb

require 'mousevc'

Jerry < Mousevc::App
end

Jerry.new(
	:controller => 'JerryController',
	:model => 'JerryModel',
	:action => ':find_cheese',
	:views => 'relative/views/directory/path'
)
```

1. Create your default controller

```ruby
# jerry_controller.rb

class JerryController < Mousevc::Controller
	def find_cheese
		cheese = @model.cheese
		@view.render('show_cheese', :cheese => cheese)
	end
end
```

1. Create the corresponding model

```ruby
# jerry_model.rb

class JerryModel < Mousevc::Model
	def cheese
		@cheese = "Swiss cheese"
	end
end
```

1. Create a view in your views directory

```erb
<%# views/show_cheese.txt.erb %>

Hello Mousevc!

I like <%= @cheese %>!
```

1. Run mouse run!

```sh
$ ruby jerry.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BideoWego/mousevc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

