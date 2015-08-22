require 'spec_helper'

describe Mousevc::Persistence do
	before(:all) do
		@model = Mousevc::Model.new
	end

	describe '#set' do
		it 'saves models with an associated key' do
			Mousevc::Persistence.set(:my_model, @model)
			expect(Mousevc::Persistence.get(:my_model).object_id).to eq(@model.object_id)
		end

		it 'raises error when overwriting a key with an existing model' do
			expect {Mousevc::Persistence.set(:my_model, Mousevc::Model.new)}.to raise_error(Mousevc::Error)
		end
	end

	describe '#get' do
		it 'retrieves a model instance via a key' do
			expect(Mousevc::Persistence.get(:my_model).object_id).to eq(@model.object_id)
		end
	end

	describe '#clear' do
		it 'deletes a model by key' do
			Mousevc::Persistence.clear(:my_model)
			expect(Mousevc::Persistence.get(:my_model)).to eq(nil)
		end

		it 'deletes all models when no argument is provided' do
			@keys = ('a'..'e').to_a
			@keys.each do |key|
				Mousevc::Persistence.set(key, Mousevc::Model.new)
			end
			Mousevc::Persistence.clear
			@keys.each do |key|
				expect(Mousevc::Persistence.get(key)).to eq(nil)
			end
		end
	end
end