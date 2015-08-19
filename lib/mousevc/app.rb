require_relative 'router.rb'
require_relative 'input.rb'
require_relative 'error.rb'

##
#
# (`) (`)
# =('o')=
#   m m  
# MousevC
# V     L
# C     I
# 

module Mousevc
	class App
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