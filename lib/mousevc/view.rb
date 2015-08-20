require 'erb'

module Mousevc

	##
	# The view rendering class of Mousevc.
	# @note Currently only supports ERB templates and a file naming convention of: +[VIEW_NAME].txt.erb+

	class View

		##
		# @!attribute dir
		#
		# @return [String] the path to the views directory

		attr_reader :dir

		##
		# Create a new +Mousevc::View+ instance

		def initialize(options={})
			@dir = options[:dir]
		end

		##
		# Renders a view, passing it the given data. In the ERB template the hash variables will be available as instance variables e.g. +@view_variable+
		#
		# @note Optionally the view output can be supressed via setting output to +false+. The view will be returned as a string allowing later output e.g. +render('view', {:data => data, false})+
		#
		# @note In the event that you want to supress output and not provide any data you may substitute +data+ for +output+ in the parameter list e.g. +render('view', false)+
		#
		# @param view [String] the name of the view with +.txt.erb+ omitted
		# @param data/output [Hash, Boolean] the data to pass to the view, or whether to supress output
		# @param output [Boolean] false causes the view output to be supressed
		# @returns [String] the rendered view as a string

		def render(view, *args)
			data = args[0].is_a?(Hash) ? args[0] : {}
			output = true
			output = false if args[0] == false || args[1] == false
			view = File.read("#{Dir.pwd}/#{@dir}/#{view}.txt.erb")
			to_ivars(data)
			result = ERB.new(view).result(binding)
			puts result if output
			result
		end

		private

			##
			# Take the given data hash and converts the key/value pairs into instance variables.
			#
			# @param data [Hash] the data to convert into instance variables.

			def to_ivars(data)
				data.to_h.each do |key, value|
					instance_variable_set("@#{key.to_s}", value)
				end
			end
	end
end