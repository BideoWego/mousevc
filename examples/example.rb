require 'mousevc'

# 1. Create your default controller
# --------------------------------

# jerry_controller.rb

class JerryController < Mousevc::Controller
	def find_cheese
		view = %Q{<%# views/show_cheese.txt.erb %>\nHello Mousevc!\nI like <%= @cheese %>!\nWhat kind of cheese do you like?}
		cheese = @model.cheese
		@view.render(view, :cheese => cheese)
		Mousevc::Input.prompt
	end
end

# 1. Create the corresponding model
# --------------------------------

# jerry_model.rb

class JerryModel < Mousevc::Model
	def cheese
		@cheese = "Swiss cheese"
	end
end

# 1. Create a class that extends `Mousevc::App`
# --------------------------------

# jerry.rb

class Jerry < Mousevc::App
end

Jerry.new(
	:controller => 'JerryController',
	:model => 'JerryModel',
	:action => :find_cheese,
	:views => 'relative/views/directory/path'
).run

# 1. Create a view in your views directory
# --------------------------------

# <%# views/show_cheese.txt.erb %>

# Hello Mousevc!
# I like <%= @cheese %>!
# What kind of cheese do you like?

# # 1. Run mouse run!
# --------------------------------

# $ ruby jerry.rb

# 1. Enjoy the view!
# --------------------------------
# =>

# Hello Mousevc!
# I like Swiss cheese!
# What kind of cheese do you like?

# > 