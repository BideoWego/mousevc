require 'spec_helper'

describe Mousevc::Error do
	it 'holds the given error message' do
		expect {raise Mousevc::Error.new("Boom!")}.to raise_error(Mousevc::Error, "Boom!")
	end
end