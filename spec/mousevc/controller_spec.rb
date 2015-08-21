require 'spec_helper'

module Mousevc
	class MyController < Mousevc::Controller
		def call_me
			@view.render('So glad you called!')
			Input.prompt
			self
		end

		def route_to_me
			@view.render('You routed to me!')
			Input.prompt
		end

		def route_from_me
			@router.action = :route_to_me
			self
		end
	end

	class DifferentController < Mousevc::Controller
		def call_me_instead
			@view.render('Can we be friends?')
			Input.prompt
		end
	end

	class MyModel < Mousevc::Model
	end
end

describe Mousevc::Controller do
	before do
		@output = WrapIO.of do
			@app = Mousevc::App.new(
				:controller => 'MyController',
				:action => :call_me,
				:system_clear => false
			)
		end
		WrapIO.of do
			@router = @app.send(:reset)
		end
		WrapIO.of do
			@controller = @router.route
		end
	end

	it 'receives messages from the router' do
		@output = WrapIO.of do
			@router.route
		end
		expect(@output).to eq("So glad you called!\n\n> ")
	end

	describe '#model' do
		it 'defaults to Model' do
			expect(@router.model).to eq('Model')
		end

		it 'can be switched to a new model' do
			@router.model = 'MyModel'
			@output = WrapIO.of do
				@controller = @router.route
			end
			expect(@router.model).to eq('MyModel')
			expect(@controller.model.class.to_s).to eq('Mousevc::MyModel')
		end
	end

	describe '#view' do
		it 'has access to the view' do
			expect(@controller.view.class.to_s).to eq('Mousevc::View')
		end
	end

	describe '#router' do
		it 'has access to the router to guide routing' do
			@router.action = :route_from_me
			WrapIO.of(['', '', 'q']) do
				@router.route
				@router.route
			end
		end

		it 'can be used to route to a different controller' do
			@router.controller = 'DifferentController'
			@router.action = :call_me_instead
			@output = WrapIO.of do
				@router.route
			end
			expect(@output).to eq("Can we be friends?\n\n> ")
		end
	end
end