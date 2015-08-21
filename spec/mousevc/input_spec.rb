require 'spec_helper'

describe Mousevc::Input do
	before do
		Mousevc::Input.clear
	end

	describe '#clear' do
		it 'sets all class variables to their original values' do
			Mousevc::Input.notice = 'Notable notes'
			Mousevc::Input.prompts.store(:dollar, '$')
			Mousevc::Input.appearance = :dollar
			Mousevc::Input.clear
			expect(Mousevc::Input.notice).to eq(nil)
			expect(Mousevc::Input.prompts).to eq({:default => '>'})
			expect(Mousevc::Input.appearance).to eq(nil)
		end

		it 'clears specific class variables from a symbol list' do
			Mousevc::Input.notice = 'Notable notes'
			Mousevc::Input.prompts.store(:dollar, '$')
			Mousevc::Input.clear(:prompts)
			expect(Mousevc::Input.notice).to eq('Notable notes')
			expect(Mousevc::Input.prompts).to eq({:default => '>'})
		end
	end

	describe '#prompts' do
		it 'is read only' do
			expect {Mousevc::Input.prompts = nil}.to raise_error(NoMethodError)
		end

		it 'defaults to a hash with the default prompt' do
			expect(Mousevc::Input.prompts).to eq({:default => '>'})
		end
	end

	describe '#appearance' do
		it 'represents the default appearance of the prompt' do
			Mousevc::Input.prompts.store(:dollar, '$')
			Mousevc::Input.appearance = :dollar
			@output = WrapIO.of do
				Mousevc::Input.prompt
			end
			expect(@output).to eq("\n$ ")
		end
	end

	describe '#prompt' do
		it 'prompts the user for input' do
			@output = WrapIO.of do
				expect($stdin).to receive(:gets)
				Mousevc::Input.prompt
			end
			expect(@output).to eq("\n> ")
		end

		it 'returns the stripped user input' do
			WrapIO.of(['      q      ']) do
				@input = Mousevc::Input.prompt
			end
			expect(@input).to eq('q')
		end

		it 'allows choosing the appearance of the prompt' do
			Mousevc::Input.prompts.store(:dollar, '$')
			@output = WrapIO.of do
				Mousevc::Input.prompt(:dollar)
			end
			expect(@output).to eq("\n$ ")
		end
	end

	describe '#notice' do
		it 'sets and gets the notice' do
			Mousevc::Input.notice = 'Notable notes!'
			expect(Mousevc::Input.notice).to eq('Notable notes!')
		end
	end

	describe '#data' do
		it 'is read only' do
			expect {Mousevc::Input.data = 'Raise the roof!'}.to raise_error(NoMethodError)
		end

		it 'returns the current user input' do
			WrapIO.of do
				Mousevc::Input.prompt
				@data = Mousevc::Input.data
			end
			expect(@data).to eq('q')
		end
	end

	describe '#notice?' do
		it 'returns true if there is a notice' do
			Mousevc::Input.notice = "I'm a gonna notify you!"
			expect(Mousevc::Input.notice?).to eq(true)
		end

		it 'returns false if notice is nil or empty' do
			expect(Mousevc::Input.notice?).to eq(false)
		end
	end

	describe '#reset?' do
		it 'returns true if the user wants to reset' do
			WrapIO.of(['r']) do
				Mousevc::Input.prompt
			end
			expect(Mousevc::Input.reset?).to eq(true)
		end

		it 'returns false if the user does not want to reset' do
			expect(Mousevc::Input.reset?).to eq(false)
		end
	end

	describe '#quit' do
		it 'returns true if the user wants to quit' do
			WrapIO.of do
				Mousevc::Input.prompt
			end
			expect(Mousevc::Input.quit?).to eq(true)
		end
		
		it 'returns false if the user does not want to quit' do
			expect(Mousevc::Input.quit?).to eq(false)
		end
	end
end