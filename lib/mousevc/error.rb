module Mousevc

	##
	# A namespaced Mousevc specific extension of Ruby's +StandardError+.

	class Error < StandardError

		##
		# Create a new +Mousevc::Error+ instance
		#
		# @param message [String] the error message

		def initialize(message)
			super(message)
		end
	end
end