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
		# @!attribute system_clear
		#
		# Setting this to false will disable calls to +system('clear')+
		# at the start of each application loop.
		#
		# @return [Boolean] whether or not to perform system clear

		attr_accessor :system_clear

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
			@system_clear = options[:system_clear].nil? ? true : options[:system_clear]
			reset
			listen
		end

		##
		# Returns true if +@system_clear+ is true
		#
		# @return [Boolean] whether or not system clearing is enabled

		def system_clear?
			@system_clear
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
					system('clear') if system_clear?
					@router.route unless Input.quit?
					reset if Input.reset?
				end until Input.quit?
				Input.clear
			end
	end
end