require 'spec_helper'

describe Mousevc::Router do
	describe '#controller' do
		it 'is the string name of the current controller'
	end

	describe '#model' do
		it 'is the string name of the current model'
	end

	describe '#action' do
		it 'it is the symbol name of the current action'
	end

	describe '#route' do
		it 'instantiates a new instance of the current controller'
		it 'sends the current controller the current action'
		it 'sends the current controller a view object'
		it 'sends the current controller an instance of the current model'
	end
end