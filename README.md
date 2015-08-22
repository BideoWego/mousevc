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

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install mousevc
```

## Usage

1. Require Mousevc

	```ruby
	require 'mousevc'
	```

1. Create a view in your views directory

	```erb
	# <%# views/show_cheese.txt.erb %>

	# Hello Mousevc!
	# I like <%= @cheese %>!
	# What kind of cheese do you like?
	```

	- or just use a string!

	```ruby
	view = %Q{<%# views/show_cheese.txt.erb %>\nHello Mousevc!\nI like <%= @cheese %>!\nWhat kind of cheese do you like?}
	```

1. Create your default controller

	```ruby
	# jerry_controller.rb

	class JerryController < Mousevc::Controller
		def find_cheese
			view = %Q{<%# views/show_cheese.txt.erb %>\nHello Mousevc!\nI like <%= @cheese %>!\nWhat kind of cheese do you like?}
			cheese = @model.cheese
			@view.render(view, :cheese => cheese)
			Mousevc::Input.prompt
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

1. Create a class that extends `Mousevc::App`

	```ruby

	# jerry.rb

	class Jerry < Mousevc::App
	end

	Jerry.new(
		:controller => 'JerryController',
		:model => 'JerryModel',
		:action => :find_cheese,
		:views => 'relative/views/directory/path'
	).run
	```

1. Run mouse run!

	```shell
	$ ruby jerry.rb
	```

1. Enjoy the view!

	```shell

	Hello Mousevc!
	I like Swiss cheese!
	What kind of cheese do you like?

	> 
	```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BideoWego/mousevc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

