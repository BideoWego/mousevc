require 'spec_helper'

describe Mousevc::App do
	it 'passes initialization variables to the router'
	it 'clears the Input class upon exiting'

	describe '#reset' do
		it 'returns a new router object'
	end

	describe '#listen' do
		it 'loops until user quits'
		it 'does not route when user wants to quit'
		it 'resets when user wants to reset'
		it 'performs a system clear on each loop'
	end
end