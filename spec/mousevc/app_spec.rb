require 'spec_helper'

describe Mousevc::App do
	it 'passes initialization variables to the router' do
		@output = WrapIO.of do
			@app = Mousevc::App.new(
				:controller => 'MyController',
				:model => 'MyModel',
				:action => :initialization_variables,
				:views => 'views',
				:system_clear => false
			)
		end
		expect(@output).to eq("MyController\nMyModel\ninitialization_variables\nviews\n\n> ")
	end

	describe '#reset' do
		it 'returns a new router object' do
			WrapIO.of do
				@app = Mousevc::App.new(:system_clear => false)
				@router = @app.send(:reset)
			end
			expect(@router.class).to eq(Mousevc::Router)
		end
	end

	describe '#listen' do
		it 'loops until user quits' do
			mock_inputs = ['', '', '', '', '', 'q']
			num_inputs = mock_inputs.length
			@output = WrapIO.of(mock_inputs) do
				@app = Mousevc::App.new(
					:controller => 'MyController',
					:action => :loops_until_quits,
					:system_clear => false
				)
			end
			calls = @output.gsub(/\s/, '').gsub('>', '').split('').max.to_i
			expect(calls).to eq(num_inputs)
		end

		it 'does not route when user wants to quit' do
			mock_inputs = ['one', 'two', 'three', 'four', 'five', 'quit']
			@output = WrapIO.of(mock_inputs) do
				@app = Mousevc::App.new(
					:controller => 'MyController',
					:action => :no_route_if_quit,
					:system_clear => false
				)
			end
			routed_after_quit = (@output =~ /quit/)
			expect(routed_after_quit).to eq(nil)
		end

		it 'resets when user wants to reset' do
			mock_inputs = ['one', 'reset', 'q']
			@output = WrapIO.of(mock_inputs) do
				@app = Mousevc::App.new(
					:controller => 'MyController',
					:action => :resets_when_desired,
					:system_clear => false
				)
			end
			ids = @output.split("\n\n> ")
			original_router_id = ids[0]
			after_reset_router_id = ids[2]
			expect(original_router_id).to_not eq(after_reset_router_id)
		end

		# it 'performs a system clear on each loop' do
		# 	@output = WrapIO.of do
		# 		expect(Kernel).to receive(:system).with('clear')
		# 		@app = Mousevc::App.new
		# 	end
		# 	expect(@app.system_clear).to eq(true)
		# end

		it 'clears the Input class upon exit' do
			@output = WrapIO.of(['some user input', 'q']) do
				@app = Mousevc::App.new( :system_clear => false)
			end
			expect(Mousevc::Input.data).to eq(nil)
		end
	end
end