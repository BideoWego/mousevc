require 'spec_helper'

describe Mousevc::Validation do
	describe '#error' do
		it 'is readable and writable'
	end

	describe '#alpha?' do
		it 'is true if the string containers only uppercase or lowercase letters'
	end

	describe '#matches?' do
		it 'is true if the value is equal to the other'
	end

	describe '#differs?' do
		it 'is true if the value is not equal to the other'
	end

	describe '#min_length?' do
		it 'is true if the value has at least the specified length'
	end

	describe '#max_length?' do
		it 'is true if the value has at most the specified length'
	end

	describe '#exact_length?' do
		it 'is true if the value has exactly the specified length'
	end

	describe '#greater_than?' do
		it 'is true if the value is greater than the other given value'
	end

	describe '#greater_than_equal_to?' do
		it 'is true if the value is greater than or equal to the other given value'
	end

	describe '#less_than?' do
		it 'is true if the value is less than the other given value'
	end

	describe '#less_than_equal_to?' do
		it 'is true if the value is less than or equal to the other given value'
	end

	describe '#numeric?' do
		it 'is true if the value is an integer or a decimal, includes positive and negative'
	end

	describe '#integer?' do
		it 'is true if the value is an integer, includes positive and negative'
	end

	describe '#decimal?' do
		it 'is true if the value is an decimal, includes positive and negative'
	end

	describe '#natural?' do
		it 'is true if the value is a positive integer'
	end

	describe '#natural_no_zero?' do
		it 'is true if the value is a positive integer greater than 0'
	end

	describe '#url?' do
		it 'is true if the value is a valid url and accounts for many edge cases'
	end

	describe '#email?' do
		it 'is true if the value is a valid email address'
	end

	describe '#ip?' do
		it 'is true if the value is a valid IP address'
	end

	describe '#password?' do
		it 'is true if the value contains only letters, numbers and has a length between the min and max of the given range'
	end

	describe '#password_caps?' do
		it 'is true if the value contains only letters, numbers and has a length, has a length between the min and max of the given range, and contains at least one uppercase letter'
	end

	describe '#password_symbols?' do
		it 'is true if the value contains only letters, numbers and has a length, has a length between the min and max of the given range, contains at least one uppercase letter, and contains at least one symbol'
	end
end