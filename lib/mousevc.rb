require_relative 'mousevc/version.rb'
require_relative 'mousevc/app.rb'

##
# Mousevc is the top level module and namespace for the Mousevc framework.

module Mousevc

	##
	# @todo Add link to documentation
	#
	# @return [String] some pretty ASCII art

	def self.art
		lines = [
			"",
			"(`) (`)",
			"=('o')=",
			"  m m  ",
			"",
			"MousevC",
			"V     L",
			"C     I",
			"",
			"by",
			"Bideo Wego",
			"http://bideowego.com/mousevc",
			"",
			"Documentation",
			"http://www.rubydoc.info/gems/mousevc"
		]
		width = lines.max.length
		width = width.even? ? width + 1 : width
		lines.map do |s|
			s.center(width)
		end.join("\n")
	end

	##
	# Generates a Mousevc class constant ready for instantiation
	#
	# @param class_name [String] the string name of the class
	# @return [Constant] the class constant

	def self.factory(class_name)
		Mousevc.const_get(class_name)
	end
end
