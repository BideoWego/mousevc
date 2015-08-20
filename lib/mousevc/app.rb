require_relative 'router.rb'
require_relative 'input.rb'
require_relative 'error.rb'

module Mousevc

	##
	# App is the top level class of Mousevc.
	# App is the container for all of the objects
	# created within a Mousevc application.

	class App

		##
		# Creates a new App instance
		#
		# Expects a parameter of type `Hash`
		# with the following format:
		# * +:controller+ -> string name of
		# the default controller class. This
		# is the controller that will be 
		# instantiated at the beginning of
		# your program.
		# * +:model+ -> string name of the
		# model that corresponds to the
		# default controller. This model
		# will be available to the controller
		# via it's @model attribute.
		# * +:action+ -> symbol name of the
		# method to call on the default
		# controller at run time. This method
		# will be the entry point for your
		# application.
		# * +:views+ -> The relative path to
		# your views directory .e.g if your
		# application lives in +app/+ and your
		# views live in a sub-directory of
		# +app/+ called +views+ then this
		# parameter should be +'views'+.
		# 
		# * *Params*:
		# 	- +options+ -> the options hash
		#

		def initialize(options={})
			@controller = options[:controller]
			@model = options[:model]
			@action = options[:action]
			@views = options[:views]
			reset
			listen
		end

		def reset
			@router = Router.new(
				:controller => @controller,
				:action => @action,
				:model => @model,
				:views => @views
			)
		end

		def listen
			begin
				system('clear')
				@router.route
				reset if Input.reset?
			end while ! Input.quit?
			Input.clear
		end
	end
end