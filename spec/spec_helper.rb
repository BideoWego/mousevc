$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative '../lib/mousevc.rb'

require 'wrapio'

WrapIO.default_input = ['q']

module Mousevc
	class MyController < Mousevc::Controller
		@@calls = 0

		def initialization_variables
			@view.render(@router.controller)
			@view.render(@router.model)
			@view.render(@router.action.to_s)
			@view.render(@view.dir)
			Input.prompt
		end

		def loops_until_quits
			@@calls += 1
			@view.render(@@calls.to_s)
			Input.prompt
		end

		def no_route_if_quit
			@view.render(Input.data.to_s)
			Input.prompt
		end

		def resets_when_desired
			@view.render(@router.object_id.to_s)
			Input.prompt
		end

		def call_me
			@view.render('So glad you called!')
			Input.prompt
			self
		end

		def route_to_me
			@view.render('You routed to me!')
			Input.prompt
		end

		def route_from_me
			@router.action = :route_to_me
			self
		end

		def self.calls
			@@calls
		end
	end

	class DifferentController < Mousevc::Controller
		def call_me_instead
			@view.render('Can we be friends?')
			Input.prompt
		end
	end

	class MyModel < Mousevc::Model
	end
end



