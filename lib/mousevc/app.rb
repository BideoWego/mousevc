require_relative 'router.rb'
require_relative 'input.rb'
require_relative 'error.rb'

module Mousevc

	##
	# The top level class of Mousevc.
	# The container for all of the objects
	# created within a Mousevc application.
	# 

	class App

		##
		# Creates a new +Mousevc::App+ instance
		# 
		# @param options [Hash] expects the following keys:
		# 	- :controller => string name of default controller class
		# 	- :model => string name of default model class
		# 	- :action => method to call on default controller
		# 	- :views => relative path to views directory

		def initialize(options={})
			@controller = options[:controller]
			@model = options[:model]
			@action = options[:action]
			@views = options[:views]
			reset
			listen
		end

		private

			##
			# Instantiates the router instance.
			# Passes the router instance the initialization options.

			def reset
				@router = Router.new(
					:controller => @controller,
					:action => @action,
					:model => @model,
					:views => @views
				)
			end

			##
			# Runs the application loop.
			# Clears the system view each iteration.
			# Calls route on the router instance.
			# 
			# If the user is trying to reset or quit the application responds accordingly.
			# Clears Input class variables before exit.

			def listen
				begin
					system('clear')
					@router.route if ! Input.quit?
					reset if Input.reset?
				end while ! Input.quit?
				Input.clear
			end
	end
end