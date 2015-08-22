require 'spec_helper'

describe Mousevc::Router do
	before do
		WrapIO.of do
			@app = Mousevc::App.new(
				:controller => 'MyController',
				:action => :call_me
			)
		end
		WrapIO.of do
			@router = @app.send(:reset)
			@controller = @router.route
		end
	end

	describe '#controller' do
		it 'is the string name of the current controller' do
			expect(@router.controller).to eq('MyController')
		end
	end

	describe '#model' do
		it 'is the string name of the current model' do
			expect(@router.model).to eq('Model')
		end
	end

	describe '#action' do
		it 'it is the symbol name of the current action' do
			expect(@router.action).to eq(:call_me)
		end
	end

	describe '#route' do
		it 'instantiates a new instance of the current controller' do
			expect(@controller).to_not eq(nil)
			expect(@controller.class).to eq(Mousevc::MyController)
		end

		it 'sends the current controller the current action' do
			expect(@controller).to_not eq(nil)
			expect(@controller.class).to eq(Mousevc::MyController)
		end

		it 'sends the current controller a view object' do
			expect(@controller.view).to_not eq(nil)
			expect(@controller.view.class).to eq(Mousevc::View)
		end

		it 'sends the current controller an instance of the current model' do
			expect(@controller.model).to_not eq(nil)
			expect(@controller.model.class).to eq(Mousevc::Model)
		end

		it 'sends the current controller a persisted model' do
			WrapIO.of do
				@model = Mousevc::Model.new
				Mousevc::Persistence.set(:my_model, @model)
				@router.model = :my_model
				@controller = @router.route
			end
			expect(@controller.model.object_id).to eq(@model.object_id)
		end
	end
end