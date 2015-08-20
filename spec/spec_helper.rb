$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mousevc'

module Helpers
	def fake_stdin(text)
		begin
			$stdin = StringIO.new
			$stdin.puts(text)
			$stdin.rewind
			yield
		ensure
			$stdin = STDIN
		end
	end

	def capture_stdout(&block)
		original_stdout = $stdout
		$stdout = fake = StringIO.new
	begin
		yield
	ensure
		$stdout = original_stdout
	end
		fake.string
	end
end

RSpec.configure do |conf|
	conf.include(Helpers)
end

class MyController < Mousevc::Controller
	def index
	end
end

class MyModel < Mousevc::Model
	def data
		"Hello Model!"
	end
end

class MyValidation < Mousevc::Validation
	def valid?(value)
		@error = "Error!" unless value
		value
	end
end