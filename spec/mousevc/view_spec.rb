require 'spec_helper'

describe Mousevc::View do
	describe '#dir' do
		it 'is the string path to the view directory'
		it 'is read only'
	end

	describe '#render' do
		it 'renders the given view'
		it 'passes the view data as instance variables'
		it 'allows the view to be returned as a string'
		it 'allows argument substitution for the data and supress output parameters'
	end
end