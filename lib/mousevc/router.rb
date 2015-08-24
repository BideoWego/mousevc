require_relative 'controller.rb'
require_relative 'model.rb'
require_relative 'view.rb'

module Mousevc

	##
	# Router routes requests to the controller method. Instantiated by the +Mousevc::App+ class.

	class Router

		##
		# @!attribute controller
		#
		# @note Set this variable to the string name of the controller class to be instantiated upon the next application loop
		#
		# @return [String] the instance of the current controller

		attr_accessor :controller

		# @!attribute model
		#
		# @note Set this variable to the string name of the model class to be instantiated upon the next application loop
		# @note Can be used to retrieve a model from the +Mousevc::Persistence+ class when set to a symbol.
		#
		# @return [String, Symbol] the instance of the current model.
		
		attr_accessor :model

		# @!attribute action
		#
		# @note Set this variable to the symbol name of the method to call on the next controller
		#
		# @return [Symbol] the action sent to the controller method

		attr_accessor :action

		##
		# Creates a new +Mousevc::Router+ instance
		#
		# @param options [Hash] expects the following keys:
		# 	- :controller => [String] name of default controller class
		# 	- :model => [String] name of default model class
		# 	- :action => [Symbol] method to call on default controller
		# 	- :views => [String] relative path to views directory

		def initialize(options={})
			@controller = options[:controller] ? options[:controller] : 'Controller'
			@model = options[:model] ? options[:model] : 'Model'
			@action = options[:action] ? options[:action] : :hello_mousevc
			@views = options[:views]
		end

		##
		# Routes by:
		#
		# 1. creating an instance of the current controller in the +@controller+ attribute
		# 1. creating an instance of the current model in the +@model+ attribute
		# 1. creating a new or finding the desired model
		# 1. passing that controller that model instance, a view instance, and an instance of +self+
		# 1. sending the controller the current action in +@action+

		def route
			model = nil
			model = Persistence.get(@controller.to_sym) unless Persistence.get(@controller.to_sym).nil?
			model = Persistence.get(@model) if @model.is_a?(Symbol)
			unless model
				model = Mousevc.factory(@model).new
				Persistence.set(@controller.to_sym, model)
			end

			view = View.new(:dir => @views)

			controller = Mousevc.factory(@controller).new(
				:view => view,
				:model => model,
				:router => self
			)
			controller.send(@action)
		end
	end
end