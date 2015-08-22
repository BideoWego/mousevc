require 'spec_helper'

describe Mousevc::Validation do
	before(:all) do
		@validation = Mousevc::Validation.new
	end

	describe '#error' do
		it 'is readable and writable' do
			@validation.error = 'Oh snap!'
			expect(@validation.error).to eq('Oh snap!')
		end
	end

	describe '#alpha?' do
		it 'is true if the string containers only uppercase or lowercase letters' do
			expect(@validation.alpha?('asdf')).to eq(true)
			expect(@validation.alpha?('asdf1234')).to eq(false)
		end
	end

	describe '#matches?' do
		it 'is true if the value is equal to the other' do
			expect(@validation.matches?(1, 1)).to eq(true)
			expect(@validation.matches?('asdf', 'asdf')).to eq(true)

			expect(@validation.matches?(0, 1)).to eq(false)
			expect(@validation.matches?('asdf', ';lkj')).to eq(false)
		end
	end

	describe '#differs?' do
		it 'is true if the value is not equal to the other' do
			expect(@validation.differs?(1, 1)).to eq(false)
			expect(@validation.differs?('asdf', 'asdf')).to eq(false)

			expect(@validation.differs?(0, 1)).to eq(true)
			expect(@validation.differs?('asdf', ';lkj')).to eq(true)
		end
	end

	describe '#min_length?' do
		it 'is true if the value has at least the specified length' do
			expect(@validation.min_length?('1234', 4)).to eq(true)
			expect(@validation.min_length?('12345', 4)).to eq(true)
			expect(@validation.min_length?('123', 4)).to eq(false)
		end
	end

	describe '#max_length?' do
		it 'is true if the value has at most the specified length' do
			expect(@validation.max_length?('1234', 4)).to eq(true)
			expect(@validation.max_length?('12345', 4)).to eq(false)
			expect(@validation.max_length?('123', 4)).to eq(true)
		end
	end

	describe '#exact_length?' do
		it 'is true if the value has exactly the specified length' do
			expect(@validation.exact_length?('1234', 4)).to eq(true)
			expect(@validation.exact_length?('12345', 4)).to eq(false)
			expect(@validation.exact_length?('123', 4)).to eq(false)
		end
	end

	describe '#greater_than?' do
		it 'is true if the value is greater than the other given value' do
			expect(@validation.greater_than?(2, 1)).to eq(true)
			expect(@validation.greater_than?(1, 2)).to eq(false)
			expect(@validation.greater_than?(2, 2)).to eq(false)
		end
	end

	describe '#greater_than_equal_to?' do
		it 'is true if the value is greater than or equal to the other given value' do
			expect(@validation.greater_than_equal_to?(2, 1)).to eq(true)
			expect(@validation.greater_than_equal_to?(1, 2)).to eq(false)
			expect(@validation.greater_than_equal_to?(2, 2)).to eq(true)
		end
	end

	describe '#less_than?' do
		it 'is true if the value is less than the other given value' do
			expect(@validation.less_than?(2, 1)).to eq(false)
			expect(@validation.less_than?(1, 2)).to eq(true)
			expect(@validation.less_than?(2, 2)).to eq(false)
		end
	end

	describe '#less_than_equal_to?' do
		it 'is true if the value is less than or equal to the other given value' do
			expect(@validation.less_than_equal_to?(2, 1)).to eq(false)
			expect(@validation.less_than_equal_to?(1, 2)).to eq(true)
			expect(@validation.less_than_equal_to?(2, 2)).to eq(true)
		end
	end

	describe '#numeric?' do
		it 'is true if the value is an integer or a decimal, includes positive and negative' do
			expect(@validation.numeric?('0')).to eq(true)
			expect(@validation.numeric?('1')).to eq(true)
			expect(@validation.numeric?('-1')).to eq(true)
			expect(@validation.numeric?('1.0')).to eq(true)
			expect(@validation.numeric?('+1.0')).to eq(true)
			expect(@validation.numeric?('-1.01e2')).to eq(true)
			expect(@validation.numeric?('-1.01e-2')).to eq(true)

			expect(@validation.numeric?('flabble babble')).to eq(false)
			expect(@validation.numeric?('flabble 1 babble 2')).to eq(false)
		end
	end

	describe '#integer?' do
		it 'is true if the value is an integer, includes positive and negative' do
			expect(@validation.integer?('0')).to eq(true)
			expect(@validation.integer?('1')).to eq(true)
			expect(@validation.integer?('-1')).to eq(true)

			expect(@validation.integer?('1.0')).to eq(false)
			expect(@validation.integer?('-1.0')).to eq(false)
			expect(@validation.integer?('flarg 1234')).to eq(false)
		end
	end

	describe '#decimal?' do
		it 'is true if the value is an decimal, includes positive and negative' do
			expect(@validation.decimal?('1.0')).to eq(true)
			expect(@validation.decimal?('-1.01e2')).to eq(true)
			expect(@validation.decimal?('.02e-2')).to eq(true)
			expect(@validation.decimal?('0.0')).to eq(true)
			expect(@validation.decimal?('0.01e1')).to eq(true)

			expect(@validation.decimal?('0')).to eq(false)
			expect(@validation.decimal?('1')).to eq(false)
			expect(@validation.decimal?('-1')).to eq(false)
			expect(@validation.decimal?('.0')).to eq(false)

			expect(@validation.decimal?('flarg 1234')).to eq(false)
		end
	end

	describe '#natural?' do
		it 'is true if the value is a positive integer' do
			expect(@validation.natural?('0')).to eq(true)
			expect(@validation.natural?('1')).to eq(true)
			expect(@validation.natural?('1234')).to eq(true)
			expect(@validation.natural?('4321')).to eq(true)

			expect(@validation.natural?('1.0')).to eq(false)
			expect(@validation.natural?('1.5')).to eq(false)
			expect(@validation.natural?('-1')).to eq(false)
			expect(@validation.natural?('-1234')).to eq(false)
			expect(@validation.natural?('1.01e-4')).to eq(false)
			expect(@validation.natural?('1.01e4')).to eq(false)
			expect(@validation.natural?('flarg')).to eq(false)
		end
	end

	describe '#natural_no_zero?' do
		it 'is true if the value is a positive integer greater than 0' do
			expect(@validation.natural_no_zero?('1')).to eq(true)
			expect(@validation.natural_no_zero?('1234')).to eq(true)
			expect(@validation.natural_no_zero?('4321')).to eq(true)

			expect(@validation.natural_no_zero?('0')).to eq(false)
			expect(@validation.natural_no_zero?('1.0')).to eq(false)
			expect(@validation.natural_no_zero?('1.5')).to eq(false)
			expect(@validation.natural_no_zero?('-1')).to eq(false)
			expect(@validation.natural_no_zero?('-1234')).to eq(false)
			expect(@validation.natural_no_zero?('1.01e-4')).to eq(false)
			expect(@validation.natural_no_zero?('1.01e4')).to eq(false)
			expect(@validation.natural_no_zero?('flarg')).to eq(false)
		end
	end

	describe '#url?' do
		it 'is true if the value is a valid url and accounts for many edge cases' do
				expect(@validation.url?("http://foo.com/blah_blah")).to eq(true)
				expect(@validation.url?("http://foo.com/blah_blah/")).to eq(true)
				expect(@validation.url?("http://foo.com/blah_blah_(wikipedia)")).to eq(true)
				expect(@validation.url?("http://foo.com/blah_blah_(wikipedia)_(again)")).to eq(true)
				expect(@validation.url?("http://www.example.com/wpstyle/?p=364")).to eq(true)
				expect(@validation.url?("https://www.example.com/foo/?bar=baz&inga=42&quux")).to eq(true)
				expect(@validation.url?("http://✪df.ws/123")).to eq(true)
				expect(@validation.url?("http://userid:password@example.com:8080")).to eq(true)
				expect(@validation.url?("http://userid:password@example.com:8080/")).to eq(true)
				expect(@validation.url?("http://userid@example.com")).to eq(true)
				expect(@validation.url?("http://userid@example.com/")).to eq(true)
				expect(@validation.url?("http://userid@example.com:8080")).to eq(true)
				expect(@validation.url?("http://userid@example.com:8080/")).to eq(true)
				expect(@validation.url?("http://userid:password@example.com")).to eq(true)
				expect(@validation.url?("http://userid:password@example.com/")).to eq(true)
				expect(@validation.url?("http://142.42.1.1/")).to eq(true)
				expect(@validation.url?("http://142.42.1.1:8080/")).to eq(true)
				expect(@validation.url?("http://➡.ws/䨹")).to eq(true)
				expect(@validation.url?("http://⌘.ws")).to eq(true)
				expect(@validation.url?("http://⌘.ws/")).to eq(true)
				expect(@validation.url?("http://foo.com/blah_(wikipedia)#cite-1")).to eq(true)
				expect(@validation.url?("http://foo.com/blah_(wikipedia)_blah#cite-1")).to eq(true)
				expect(@validation.url?("http://foo.com/unicode_(✪)_in_parens")).to eq(true)
				expect(@validation.url?("http://foo.com/(something)?after=parens")).to eq(true)
				expect(@validation.url?("http://☺.damowmow.com/")).to eq(true)
				expect(@validation.url?("http://code.google.com/events/#&product=browser")).to eq(true)
				expect(@validation.url?("http://j.mp")).to eq(true)
				expect(@validation.url?("ftp://foo.bar/baz")).to eq(true)
				expect(@validation.url?("http://foo.bar/?q=Test%20URL-encoded%20stuff")).to eq(true)
				expect(@validation.url?("http://www.foo.bar./")).to eq(true)
				expect(@validation.url?("http://مثال.إختبار")).to eq(true)
				expect(@validation.url?("http://例子.测试")).to eq(true)
				expect(@validation.url?("http://उदाहरण.परीक्षा")).to eq(true)
				expect(@validation.url?("http://-.~_!$&'()*+,;=:%40:80%2f::::::@example.com")).to eq(true)
				expect(@validation.url?("http://1337.net")).to eq(true)
				expect(@validation.url?("http://a.b-c.de")).to eq(true)
				expect(@validation.url?("http://223.255.255.254")).to eq(true)


				expect(@validation.url?("http://")).to eq(false)
				expect(@validation.url?("http://.")).to eq(false)
				expect(@validation.url?("http://..")).to eq(false)
				expect(@validation.url?("http://../")).to eq(false)
				expect(@validation.url?("http://?")).to eq(false)
				expect(@validation.url?("http://??")).to eq(false)
				expect(@validation.url?("http://??/")).to eq(false)
				expect(@validation.url?("http://#")).to eq(false)
				expect(@validation.url?("http://##")).to eq(false)
				expect(@validation.url?("http://##/")).to eq(false)
				expect(@validation.url?("http://foo.bar?q=Spaces should be encoded")).to eq(false)
				expect(@validation.url?("//")).to eq(false)
				expect(@validation.url?("//a")).to eq(false)
				expect(@validation.url?("///a")).to eq(false)
				expect(@validation.url?("///")).to eq(false)
				expect(@validation.url?("http:///a")).to eq(false)
				expect(@validation.url?("foo.com")).to eq(false)
				expect(@validation.url?("rdar://1234")).to eq(false)
				expect(@validation.url?("h://test")).to eq(false)
				expect(@validation.url?("http:// shouldfail.com")).to eq(false)
				expect(@validation.url?(":// should fail")).to eq(false)
				expect(@validation.url?("http://foo.bar/foo(bar)baz quux")).to eq(false)
				expect(@validation.url?("ftps://foo.bar/")).to eq(false)
				expect(@validation.url?("http://-error-.invalid/")).to eq(false)
				expect(@validation.url?("http://a.b--c.de/")).to eq(false)
				expect(@validation.url?("http://-a.b.co")).to eq(false)
				expect(@validation.url?("http://a.b-.co")).to eq(false)
				expect(@validation.url?("http://0.0.0.0")).to eq(false)
				expect(@validation.url?("http://10.1.1.0")).to eq(false)
				expect(@validation.url?("http://10.1.1.255")).to eq(false)
				expect(@validation.url?("http://224.1.1.1")).to eq(false)
				expect(@validation.url?("http://1.1.1.1.1")).to eq(false)
				expect(@validation.url?("http://123.123.123")).to eq(false)
				expect(@validation.url?("http://3628126748")).to eq(false)
				expect(@validation.url?("http://.www.foo.bar/")).to eq(false)
				expect(@validation.url?("http://10.1.1.1")).to eq(false)
				expect(@validation.url?("http://10.1.1.254")).to eq(false)
		end
	end

	describe '#email?' do
		it 'is true if the value is a valid email address' do
			expect(@validation.email?(%Q{email@example.com})).to eq(true)
			expect(@validation.email?(%Q{firstname.lastname@example.com})).to eq(true)
			expect(@validation.email?(%Q{email@subdomain.example.com})).to eq(true)
			expect(@validation.email?(%Q{firstname+lastname@example.com})).to eq(true)
			expect(@validation.email?(%Q{email@123.123.123.123})).to eq(true)
			expect(@validation.email?(%Q{email@[123.123.123.123]})).to eq(true)
			expect(@validation.email?(%Q{"email"@example.com})).to eq(true)
			expect(@validation.email?(%Q{1234567890@example.com})).to eq(true)
			expect(@validation.email?(%Q{email@example-one.com})).to eq(true)
			expect(@validation.email?(%Q{_______@example.com})).to eq(true)
			expect(@validation.email?(%Q{email@example.name})).to eq(true)
			expect(@validation.email?(%Q{email@example.museum})).to eq(true)
			expect(@validation.email?(%Q{email@example.co.jp})).to eq(true)
			expect(@validation.email?(%Q{firstname-lastname@example.com})).to eq(true)
			expect(@validation.email?(%Q{much."more\ unusual"@example.com})).to eq(true)
			expect(@validation.email?(%Q{very.unusual."@".unusual.com@example.com})).to eq(true)
			expect(@validation.email?(%Q{very."(),:;<>[]".VERY."very@\\ "very".unusual@strange.example.com})).to eq(true)

			expect(@validation.email?(%Q{plainaddress})).to eq(false)
			expect(@validation.email?(%Q{@example.com})).to eq(false)
			expect(@validation.email?(%Q{email.example.com})).to eq(false)
		end
	end

	describe '#ip?' do
		it 'is true if the value is a valid IP address' do
			expect(@validation.ip?('255.255.255.255')).to eq(true)
			expect(@validation.ip?('0.0.0.0')).to eq(true)
			expect(@validation.ip?('67.52.159.38')).to eq(true)
			expect(@validation.ip?('067.052.159.038')).to eq(true)

			expect(@validation.ip?('256.256.256.256')).to eq(false)
			expect(@validation.ip?('99999.9999.999.99')).to eq(false)
		end
	end

	describe '#password?' do
		it 'is true if the value contains only letters, numbers and has a length between the min and max of the given range' do
			expect(@validation.password?('abcd1234')).to eq(true)

			expect(@validation.password?('abcd123')).to eq(false)
			expect(@validation.password?('abcdefghi123456789asdf1234')).to eq(false)
			expect(@validation.password?('asdf;lkjasdf')).to eq(false)
			expect(@validation.password?('ABCD12345')).to eq(false)
			expect(@validation.password?('ABCDEFGHI')).to eq(false)
		end
	end

	describe '#password_caps?' do
		it 'is true if the value contains only letters, numbers and has a length, has a length between the min and max of the given range, and contains at least one uppercase letter' do
			expect(@validation.password_caps?('Abcd1234')).to eq(true)

			expect(@validation.password_caps?('abcd1234')).to eq(false)
			expect(@validation.password_caps?('abcd123')).to eq(false)
			expect(@validation.password_caps?('abcdefghi123456789asdf1234')).to eq(false)
			expect(@validation.password_caps?('asdf;lkjasdf')).to eq(false)
			expect(@validation.password_caps?('ABCD12345')).to eq(false)
			expect(@validation.password?('ABCDEFGHI')).to eq(false)
		end
	end

	describe '#password_symbols?' do
		it 'is true if the value contains only letters, numbers and has a length, has a length between the min and max of the given range, contains at least one uppercase letter, and contains at least one symbol' do
			expect(@validation.password_symbols?('Abcd1234#')).to eq(true)

			expect(@validation.password_symbols?('abcd1234')).to eq(false)
			expect(@validation.password_symbols?('abcd123')).to eq(false)
			expect(@validation.password_symbols?('abcdefghi123456789asdf1234')).to eq(false)
			expect(@validation.password_symbols?('asdf;lkjasdf')).to eq(false)
			expect(@validation.password_symbols?('ABCD12345')).to eq(false)
			expect(@validation.password?('ABCDEFGHI')).to eq(false)
		end
	end
end