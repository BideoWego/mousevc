module Mousevc
	class Controller
		attr_accessor :model, :view

		def initialize(options={})
			@model = options[:model]
			@view = options[:view]
			@router = options[:router]
		end
	end
end