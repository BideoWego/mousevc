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