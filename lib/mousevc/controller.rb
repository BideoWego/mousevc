module Mousevc

	##
	# Base controller class in Mousevc.
	# Handles communication with the model.
	# Decides which view to output.

	class Controller

		##
		# @!attribute model
		#
		# An instance of the +Mousevc::Model+ class.
		# This will be an instance of the model class passed to the application during initialization.
		# It is also possible to change this via +@router.model+
		#
		# @return [Mousevc::Model] the controller's model

		attr_accessor :model

		##
		# @!attribute view [r]
		#
		# An instance of the +Mousevc::View+ class
		#
		# @return [Mousevc::View] the view instance

		attr_reader :view

		##
		# Creates a new +Mousevc::Controller+ instance
		#
		# @note Controllers should not be instantiated directly. Pass the name of the controller you wish you instantiate to the router via +@router.controller+ along with a model and action. This allows the router to do the work for you on the next application execution or loop.
		#
		# @param options [Hash] expects the following keys:
		# 	- :model => [Mousevc::Model] a reference to the controller's model instance
		# 	- :view => [Mousevc::View] a reference to the view instance
		# 	- :router => [Mousevc::Router] a reference to the router instance

		def initialize(options={})
			@model = options[:model]
			@view = options[:view]
			@router = options[:router]
		end

		private

			##
			# Outputs the default Mousevc welcome

			def hello_mousevc
				puts Mousevc.art
				Input.prompt
			end
	end
end