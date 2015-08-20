module Mousevc

	##
	# Extend this class to perform validations on user input in your model.
	# Use the +@error+ attribute to pass notices to the +Mousevc::Input+ class.
	# From there the notice can be easily output in your views.

	class Validation

		##
		# @!attribute error
		#
		# @return [String] the error message generated during validation

		attr_accessor :error
	end
end