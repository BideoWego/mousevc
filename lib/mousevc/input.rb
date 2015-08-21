module Mousevc

	##
	# A globally accessible class to allow access to user input and provide input specific notices.

	class Input

		##
		# @!attribute notice
		# @return [String] the notice message
		@@notice = nil

		##
		# @!attribute data [r]
		# @return [String] the user input data retrieved via +Input.prompt+
		@@data = nil

		##
		# @!attribute prompts [r]
		# @return [Hash] a hash of prompts available for use in +Input.prompt+

		@@prompts = {:default => '>'}

		##
		# @!attribute appearance
		# @return [Symbol] the symbol name of the prompt appearance to use from +Input.prompts+

		@@appearance = nil

		##
		# @return [Symbol] the symbol name of the current prompt appearance

		def self.appearance
			@@appearance
		end

		##
		# Set the default appearance for the prompt
		#
		# @param value [Symbol] the symbol name of the appearance to use from +Input.prompts+

		def self.appearance=(value)
			@@appearance = value
		end

		##
		# Clears all or a list of class variables by setting them to +nil+.
		#
		# @param args [Symbol] a symbol list of class variables to clear

		def self.clear(*args)
			if args.empty?
				@@notice = nil
				@@data = nil
				@@prompts = {:default => '>'}
				@@appearance = nil
			else
				args.each {|arg| self.send("#{arg}=".to_sym, nil)}
			end
		end

		##
		# @note Calling this method will stop all execution until the user submits input
		#
		# Prompts the user for input using +gets.strip+
		# Once input is submitted it will be available via +Input.data+
		#
		# @param appearance [Symbol] the symbol name of the prompt the use from +Input.prompts+
		# 	- If an appearance is not specified it uses +:default+

		def self.prompt(appearance=nil)
			if appearance
				appearance = @@prompts[appearance]
			elsif @@appearance
				appearance = @@prompts[@@appearance]
			else
				appearance = @@prompts[:default]
			end
			print "\n#{appearance} "
			@@data = $stdin.gets.strip
		end

		##
		# @return [Hash] a hash of the currently available prompt appearances

		def self.prompts
			@@prompts
		end

		##
		# Get the notice message
		#
		# @return [String] the notice message

		def self.notice
			@@notice
		end

		##
		# Set the notice message. This is a good place to put error messages corresponding to user input
		#
		# @param value [String] the notice message

		def self.notice=(value)
			@@notice = value
		end

		##
		# Get the current value of user input retrieved via +Input.prompt+
		#
		# @return [String] the data

		def self.data
			@@data
		end

		##
		# Check if a notice message exists
		#
		# @return [Boolean] false if notice message is empty

		def self.notice?
			! @@notice.to_s.empty?
		end

		##
		# Check if the user is trying to reset the application
		#
		# @return [Boolean] true if +Input.data+ is +r+ or +reset+

		def self.reset?
			['r', 'reset'].include?(@@data)
		end

		##
		# Check if the user is trying to quit the application
		#
		# @return [Boolean] true if +Input.data+ is +q+, +quit+, or +exit+

		def self.quit?
			['q', 'quit', 'exit'].include?(@@data)
		end

		##
		# Check if the user is tring to clear the input data
		#
		# @return [Boolean] true if +Input.data+ is +c+ or +clear+

		def self.clear?
			['c', 'clear'].include?(@@data)
		end

		clear
	end
end