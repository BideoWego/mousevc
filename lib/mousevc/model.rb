require_relative 'validation.rb'

module Mousevc

	##
	# The base model class for a Mousevc application.
	# Provides access to basic functionality for validating input before modifying data
	# via it's +@validation+ attribute, an instance of the +Mousevc::Validation+ class.

	class Model

		##
		# @!attribute [r]
		# @return [Mousevc::Validation] a reference to the model's validation instance

		attr_reader :validation

		##
		# Creates a new +Mousevc::Model+ instance
		#
		# @param options [Hash] optionally accepts the following keys:
		# 	- :validation => [Mousevc::Router] an instance of the +Mousevc::Validation+ class

		def initialize(options={})
			@validation = options[:validation] ? options[:validation] : Validation.new
			clear
		end

		##
		# Overridable empty method for clearing data in the model subclass

		def clear
		end
	end
end