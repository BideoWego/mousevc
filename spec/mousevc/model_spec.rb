require 'spec_helper'

describe Mousevc::Model do
	describe '#validation' do
		it 'defaults to an instance of Mousevc::Validation' do
			@model = Mousevc::Model.new
			expect(@model.validation.class).to eq(Mousevc::Validation)
		end
	end
end