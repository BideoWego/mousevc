require 'spec_helper'

describe Mousevc do
	it 'has a version number' do
		expect(Mousevc::VERSION).not_to be(nil)
	end

	describe '#art' do
		it 'returns ascii art' do
			art = Mousevc.art
			expect(art).to be_a(String)
		end
	end

	describe '#factory' do
		it 'returns a the Mousevc class constant of the specified class' do
			expect(Mousevc.factory('Controller')).to eq(Mousevc::Controller)
		end
	end
end
