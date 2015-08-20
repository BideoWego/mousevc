require 'spec_helper'

describe Mousevc::Controller do
	it 'receives messages from the router'

	describe '#model' do
		it 'has access to the current model'
		it 'can be switched to a new model'
	end

	describe '#view' do
		it 'has access to the view'
	end

	describe '#router' do
		it 'has access to the router'
		it 'can be used to route to a different controller'
	end
end