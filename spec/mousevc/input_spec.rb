require 'spec_helper'

describe Mousevc::Input do
	describe '#clear' do
		it 'clears all class variables by setting them to nil'
		it 'clears specific class variables from a symbol list'
	end

	describe '#prompts' do
		it 'is read only'
		it 'defaults to a hash with the default prompt'
	end

	describe '#appearance' do
		it 'represents the default appearance of the prompt'
	end

	describe '#prompt' do
		it 'prompts the user for input'
		it 'returns the stripped user input'
		it 'allows choosing the appearance of the prompt'
	end

	describe '#notice' do
		it 'returns the current notice'
		it 'sets the notice'
	end

	describe '#data' do
		it 'is read only'
		it 'returns the current user input'
	end

	describe '#notice?' do
		it 'returns true if there is a notice'
		it 'returns false if notice is nil or empty'
	end

	describe '#reset?' do
		it 'returns true if the user wants to reset'
		it 'returns false if the user does not want to reset'
	end

	describe '#quit' do
		it 'returns true if the user wants to quit'
		it 'returns false if the user does not want to quit'
	end
end