module Mousevc
	class Error < StandardError
		def initialize(message)
			super(message)
		end
	end
end