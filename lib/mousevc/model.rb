require_relative 'validation.rb'

module Mousevc
	class Model
		attr_reader :validation

		def initialize(options={})
			@validation = options[:validation] ? options[:validation] : Validation.new
			clear
		end

		def clear
		end
	end
end