require_relative 'router.rb'
require_relative 'input.rb'
require_relative 'error.rb'
require_relative 'persistence.rb'

module Mousevc

	## true
	# The top level class of Mousevc.
	# The container for all of the objects
	# created within a Mousevc application.

	class App

		##
		# @!attribute system_clear
		#
		# Setting this to +false+ will disable calls to +system('clear')+
		# at the start of each application loop.
		#
		# @return [Boolean] whether or not to perform system clear

		attr_accessor :system_clear

		##
		# @!attribute looping
		#
		# Set this to +true+ if you want the application to loop, defaults to +false+
		#
		# @return [Boolean] whether or not the application should loop

		attr_accessor :looping

		##
		# @!attribute router
		#
		# Returns the current router
		#
		# @return [Mousevc::Router] the router

		attr_reader :router

		##
		# Creates a new +Mousevc::App+ instance
		# 
		# @param options [Hash] expects the following keys:
		# 	- :controller => [String] name of default controller class
		# 	- :model => [String] name of default model class
		# 	- :action => [Symbol] method to call on default controller
		# 	- :views => [String] the absolute path to your views directory
		# 	- :looping => [Boolean] +true+ if the application should loop, defaults to +false+
		# 	- :system_clear => [Boolean] +true+ if output should be cleared on update, defaults to +false+

		def initialize(options={})
			@controller = options[:controller]
			@model = options[:model]
			@action = options[:action]
			@views = options[:views]
			@looping = options[:looping].nil? ? false : options[:looping]
			@system_clear = options[:system_clear].nil? ? false : options[:system_clear]
		end

		##
		# Runs the application

		def run
			reset
			@looping ? listen : single
			Input.clear
			nil
		end

		##
		# Returns +true+ if +@system_clear+ is true
		#
		# @return [Boolean] whether or not system clearing is enabled

		def system_clear?
			@system_clear
		end

		##
		# Returns +true+ if +@looping+ is set to +true+

		def looping?
			@looping
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
			# Runs the application without looping automatically

			def single
				clear_view
				@router.route
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
					clear_view
					@router.route unless Input.quit?
					reset if Input.reset?
				end until Input.quit?
			end

			##
			# Executes a system clear if system clearing is enabled

			def clear_view
				Kernel.system('clear') if system_clear?
			end
	end
end