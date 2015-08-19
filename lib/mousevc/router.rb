require_relative 'controller.rb'
require_relative 'model.rb'
require_relative 'view.rb'

module Mousevc
	class Router
		attr_accessor :controller, :action

		def initialize(options={})
			@controller = options[:controller]
			@model = Object.const_get(options[:model]).new
			@action = options[:action]
			@view = View.new(:dir => options[:views])
		end

		def route
			controller = Object.const_get(@controller).new(
				:view => @view,
				:model => @model,
				:router => self
			)
			controller.send(@action) if ! Input.quit?
		end
	end
end