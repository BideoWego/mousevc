require 'spec_helper'

describe Mousevc::View do
	let(:dir){"#{File.dirname(__FILE__)}/views"}
	before do
		@view = Mousevc::View.new(:dir => dir)
	end

	describe '#dir' do
		it 'is the string path to the view directory' do
			expect(@view.dir).to eq(dir)
		end

		it 'is read only' do
			expect {@view.dir = nil}.to raise_error(NoMethodError)
		end
	end

	describe '#render' do
		it 'renders the given view from file' do
			@output = WrapIO.of do
				@view.render('test', :test => 'Testing...')
			end
			expect(@output).to eq("Hello View!\nTesting...\n")
		end

		it 'renders an erb template from a string' do
			@output = WrapIO.of do
				@view.render("Hello View!\n<%= @test %>\n", :test => 'Testing...')
			end
			expect(@output).to eq("Hello View!\nTesting...\n")
		end

		it 'passes the view data as instance variables' do
			@output = WrapIO.of do
				@view.render('test', :test => 'Testing...')
			end
			expect(@output).to eq("Hello View!\nTesting...\n")
			expect(@view.instance_variables.include?(:@test)).to eq(true)
		end

		it 'allows the view to be returned as a string' do
			@output = @view.render('test', {:test => 'Testing...'}, false)
			expect(@output).to eq("Hello View!\nTesting...")
		end

		it 'allows argument substitution for the data and supress output parameters' do
			@output = @view.render("Hello!", false)
			expect(@output).to eq("Hello!")

			@output = @view.render("Hello <%= @world %>!", {:world => 'world'}, false)
			expect(@output).to eq("Hello world!")			
		end
	end
end