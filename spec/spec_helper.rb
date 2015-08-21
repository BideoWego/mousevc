$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative '../lib/mousevc.rb'


module Helpers
	class Fake
		@debug = false

		def initialize(strings)
			@strings = strings
		end

		def gets
			next_string = @strings.shift
			puts "(DEBUG) Faking #gets with: #{next_string}" if @debug
			next_string
		end

		def self.input(strings)
			begin
				$stdin = new(strings)
				yield
			ensure
				$stdin = STDIN
			end
		end
	end

	class Capture
		def self.output
			$stdout = captor = StringIO.new
			begin
				yield
			ensure
				$stdout = STDOUT
			end
			captor.string
		end
	end

	class WrapIO
		def self.of(input=['q'])
			Capture.output do 
				Fake.input(input) do
					yield
				end
			end
		end
	end
end

include Helpers

module Mousevc
	class MyController < Mousevc::Controller
		@@calls = 0

		def initialize(options={})
			super(options)
		end

		def initialization_variables
			@view.render(@router.controller)
			@view.render(@router.model)
			@view.render(@router.action.to_s)
			@view.render(@view.dir)
			Input.prompt
		end

		def loops_until_quits
			@@calls += 1
			@view.render(@@calls.to_s)
			Input.prompt
		end

		def no_route_if_quit
			@view.render(Input.data.to_s)
			Input.prompt
		end

		def resets_when_desired
			@view.render(@router.object_id.to_s)
			Input.prompt
		end

		def call_me
			@view.render('So glad you called!')
			Input.prompt
			self
		end

		def route_to_me
			@view.render('You routed to me!')
			Input.prompt
		end

		def route_from_me
			@router.action = :route_to_me
			self
		end
	end

	class DifferentController < Mousevc::Controller
		def call_me_instead
			@view.render('Can we be friends?')
			Input.prompt
		end
	end

	class MyModel < Mousevc::Model
	end
end