module Mousevc

	##
	# Extend this class to perform validations on user input in your model.
	# Use the +@error+ attribute to pass notices to the +Mousevc::Input+ class.
	# From there the notice can be easily output in your views.
	#
	# Each predicate method in this class sets the appropriate error message ready
	# to be output to the user.

	class Validation

		##
		# @!attribute error
		#
		# @return [String] the error message generated during validation

		attr_accessor :error

		##Returns +true+ True if the string containers only uppercase or lowercase letters
		#
		# @param value [String] the value
		# @return [Boolean]

		def alpha?(value)
			is_alpha = coerce_bool (value =~ /^[a-zA-Z]+$/)
			unless is_alpha
				@error = "Error, expected only alphabetical characters, got: #{value}"
			end
			is_alpha
		end

		##Returns +true+ True if the value is equal to the other
		#
		# @param value [Any] the value
		# @param other [Any] the other value
		# @return [Boolean]

		def matches?(value, other)
			is_match = coerce_bool (value == other)
			unless is_match
				@error = "Error, expected value to match: #{other}, got: #{value}"
			end
			is_match
		end

		##Returns +true+ True if the value is not equal to the other
		#
		# @param value [Any] the value
		# @param other [Any] the other value
		# @return [Boolean]

		def differs?(value, other)
			is_different = coerce_bool (value != other)
			unless is_different
				@error = "Error, expected value to differ from: #{other}, got: #{value}"
			end
			is_different
		end

		##Returns +true+ True if the value has at least the specified length
		#
		# @param value [String] the value
		# @param length [Integer] the length
		# @return [Boolean]

		def min_length?(value, length)
			has_min_length = coerce_bool (value.length >= length)
			unless has_min_length
				@error = "Error, expected value to have at least #{length} characters, got: #{value.length}"
			end
			has_min_length
		end

		##Returns +true+ True if the value has at most the specified length
		#
		# @param value [String] the value
		# @param length [Integer] the length
		# @return [Boolean]

		def max_length?(value, length)
			has_max_length = coerce_bool (value.length <= length)
			unless has_max_length
				@error = "Error, expected value to have at most #{length} characters, got: #{value.length}"
			end
			has_max_length
		end

		##Returns +true+ True if the value has exactly the specified length
		#
		# @param value [String] the value
		# @param length [Integer] the length
		# @return [Boolean]

		def exact_length?(value, length)
			has_exact_length = coerce_bool (value.length == length)
			unless has_exact_length
				@error = "Error, expected value to have exactly #{length} characters, got: #{value.length}"
			end
			has_exact_length
		end

		##
		# Returns +true+ if the value is greater than the other given value
		# @note This method does note covert strings to numbers
		#
		# @param value [Mixed] the value
		# @param other [Mixed] the other value
		# @return [Boolean]

		def greater_than?(value, other)
			is_greater = coerce_bool (value > other)
			unless is_greater
				@error = "Error, expected value to be greater than #{other}, got: #{value}"
			end
			is_greater
		end

		##
		# Returns +true+ if the value is greater than or equal to the other given value
		# @note This method does note covert strings to numbers
		#
		# @param value [Mixed] the value
		# @param other [Mixed] the other value
		# @return [Boolean]

		def greater_than_equal_to?(value, other)
			is_greater_eq = coerce_bool (value >= other)
			unless is_greater_eq
				@error = "Error, expected value to be greater than or equal to #{other}, got: #{value}"
			end
			is_greater_eq
		end

		##
		# Returns +true+ if the value is less than the other given value
		# @note This method does note covert strings to numbers
		#
		# @param value [Mixed] the value
		# @param other [Mixed] the other value
		# @return [Boolean]

		def less_than?(value, other)
			is_less = coerce_bool (value < other)
			unless is_less
				@error = "Error, expected value to be less than #{other}, got: #{value}"
			end
			is_less
		end

		##
		# Returns +true+ if the value is less than or equal to the other given value
		# @note This method does note covert strings to numbers
		#
		# @param value [Mixed] the value
		# @param other [Mixed] the other value
		# @return [Boolean]

		def less_than_equal_to?(value, other)
			is_less_eq = coerce_bool (value <= other)
			unless is_less_eq
				@error = "Error, expected value to be less than or equal to #{other}, got: #{value}"
			end
			is_less_eq
		end

		##Returns +true+ True if the value is an integer or a decimal, includes positive and negative
		#
		# @param value [String] the value
		# @return [Boolean]

		def numeric?(value)
			is_numeric = (integer?(value) || decimal?(value))
			unless is_numeric
				@error = "Error, expected value to be numeric, got: #{value}"
			end
			is_numeric
		end

		##Returns +true+ True if the value is an integer, includes positive and negative
		#
		# @param value [String] the value
		# @return [Boolean]

		def integer?(value)
			is_integer = coerce_bool (value =~ /^[-+]?\d+$/)
			unless is_integer
				@error = "Error, expected value to be an integer, got: #{value}"
			end
			is_integer
		end

		##Returns +true+ True if the value is an decimal, includes positive and negative
		#
		# @param value [String] the value
		# @return [Boolean]

		def decimal?(value)
			is_decimal = coerce_bool (value =~ /[+-]?[\d_]+\.[\d_]+(e[+-]?[\d_]+)?\b|[+-]?[\d_]+e[+-]?[\d_]+\b/i)
			unless is_decimal
				@error = "Error, expected value to be a decimal, got: #{value}"
			end
			is_decimal
		end

		##Returns +true+ True if the value is a positive integer
		#
		# @param value [String] the value
		# @return [Boolean]

		def natural?(value)
			is_natural = coerce_bool (value =~ /^\d+$/)
			unless is_natural
				@error = "Error, expected value to be a natural number, got: #{value}"
			end
			is_natural
		end

		##Returns +true+ True if the value is a positive integer greater than 0
		#
		# @param value [String] the value
		# @return [Boolean]

		def natural_no_zero?(value)
			is_natural_no_zero = coerce_bool (value =~ /^[1-9]+$/)
			unless is_natural_no_zero
				@error = "Error, expected value to be a natural number above 0, got: #{value}"
			end
			is_natural_no_zero
		end

		##Returns +true+ True if the value is a valid url and accounts for many edge cases
		#
		# @param value [String] the value
		# @return [Boolean]

		def url?(value)
			is_url = coerce_bool (value =~ /^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-{1})*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-{1})*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,}))\.?)(?::\d{2,5})?(?:[\/?#]\S*)?$/i)
			unless is_url
				@error = "Error, expected value to be a url, got: #{value}"
			end
			is_url
		end

		##Returns +true+ True if the value is a valid email address
		#
		# @note This method is more a validation that the value is probably an email. The best way to confirm an email is to require the user to enter it twice, compare them, and ultimately send them an email!
		#
		# @param value [String] the value
		# @return [Boolean]

		def email?(value)
			is_email = coerce_bool (value =~ /.+@.+/)
			unless is_email
				@error = "Error, expected value to be an email address, got: #{value}"
			end
			is_email
		end

		##Returns +true+ True if the value is a valid IP address
		#
		# @param value [String] the value
		# @return [Boolean]

		def ip?(value)
			is_ip = coerce_bool (value =~ /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/)
			unless is_ip
				@error = "Error, expected value to be an IP address, got: #{value}"
			end
			is_ip
		end

		##
		# Returns +true+ if the value contains only letters, numbers
		# and has a length between the min and max of the given range
		#
		# @param value [String] the value
		# @param range [Range] the min and max length of the password, defaults to +8..15+
		# @return [Boolean]

		def password?(value, range=8..15)
			is_password = coerce_bool (value =~ /^(?!.*["'])(?=.*\d)(?=.*[a-z])\S{#{range.min},#{range.max}}$/)
			unless is_password
				@error = "Error, expected value to contain only lowercase letters, numbers, and have length between #{range.min} and #{range.max}, got: #{value}"
			end
			is_password
		end

		##
		# Returns +true+ if the value contains only letters, numbers and has a length,
		# has a length between the min and max of the given range,
		# and contains at least one uppercase letter
		#
		# @param value [String] the value
		# @param range [Range] the min and max length of the password, defaults to +8..15+
		# @return [Boolean]

		def password_caps?(value, range=8..15)
			is_password_caps = coerce_bool (value =~ /^(?!.*["'])(?=.*\d)(?=.*[A-Z])(?=.*[a-z])\S{#{range.min},#{range.max}}$/)
			unless is_password_caps
				@error = "Error, expected value to contain lowercase letters, numbers, have length between #{range.min} and #{range.max} and at least one uppercase letter, got: #{value}"
			end
			is_password_caps
		end

		##
		# Returns +true+ if the value contains only letters, numbers and has a length,
		# has a length between the min and max of the given range,
		# contains at least one uppercase letter,
		# and contains at least one symbol
		#
		# @note Excludes single and double quotes.
		#
		# @param value [String] the value
		# @param range [Range] the min and max length of the password, defaults to +8..15+
		# @return [Boolean]

		def password_symbols?(value, range=8..15)
			is_password_symbols = coerce_bool (value =~ /^(?!.*["'])(?=.*[~!@#$%^&*()_+\-\\|{}<>\[\]:;?\/])(?=.*\d)(?=.*[A-Z])(?=.*[a-z])\S{#{range.min},#{range.max}}$/)
			unless is_password_symbols
				@error = @error = "Error, expected value to contain lowercase letters, numbers, have length between #{range.min} and #{range.max}, at least one uppercase letter and at least one symbol, got: #{value}"
			end
			is_password_symbols
		end

		protected

			##
			# A method used to guarantee a value is converted explicitly into either +true+ or +false+
			#
			# @param value [Any] the original value
			# @return [Boolean]

			def coerce_bool(value)
				!!value
			end

	end
end