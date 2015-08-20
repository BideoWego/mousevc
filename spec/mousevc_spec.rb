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
end
