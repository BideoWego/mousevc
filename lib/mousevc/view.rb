require 'erb'

module Mousevc
	class View
		attr_accessor :dir

		def initialize(options={})
			@dir = options[:dir]
		end

		def render(view, data={}, output=true)
			view = File.read("#{Dir.pwd}/#{@dir}/#{view}.txt.erb")
			to_ivars(data)
			result = ERB.new(view).result(binding)
			puts result if output
			result
		end

		private
			def to_ivars(data)
				data.to_h.each do |key, value|
					instance_variable_set("@#{key.to_s}", value)
				end
			end
	end
end