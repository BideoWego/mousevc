module Mousevc

	##
	# The +Persistance+ class enables storage and retrieval of models.
	# While it is intended for storing models it can store
	# any value as internally it stores the value in a Ruby Hash.
	#
	# @note The +Persistance+ class only stores data during the application life cycle. Once the application quits the data may still exist in memory if not explicitly cleared, however it should not be relied upon to be their for subsequent executions.

	class Persistence

		##
		# Internal data storage

		@@models = {}

		##
		# Allows clearing of all or some of the models currently stored.
		# Clears all data and models stored if no keys are provided
		#
		# @param args [Symbol] a list of keys to clear from the currently stored models

		def self.clear(*args)
			if args.empty?
				@@models.clear
			else
				args.each {|arg| @@models.delete(arg)}
			end
		end

		##
		# Get a stored model by key
		#
		# @param key [Symbol] the key under which the model is stored
		# @return [Mousevc::Model, Any] the stored model or value

		def self.get(key)
			@@models[key]
		end

		##
		# Set the value of a storage key
		# @raise [Mousevc::Error] if the key already exists
		#
		# @param key [Symbol] the key under which the model is stored

		def self.set(key, value)
			raise Error.new("Cannot persist, a value already exists at: #{key}") unless @@models[key].nil?
			@@models.store(key, value)
		end
	end
end