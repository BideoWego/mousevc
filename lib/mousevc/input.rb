module Mousevc
	class Input
		@@notice = nil
		@@data = nil

		def self.clear(*args)
			if args.empty?
				@@notice = nil
				@@data = nil
			else
				args.each {|arg| self.send("#{arg}=".to_sym, nil)}
			end
		end

		def self.notice
			@@notice
		end

		def self.notice=(value)
			@@notice = value
		end

		def self.data
			@@data
		end

		def self.data=(value)
			@@data = value
		end

		def self.prompt
			print "\n> "
			@@data = gets.chomp
		end

		def self.notice?
			! @@notice.to_s.empty?
		end

		def self.reset?
			['r', 'reset'].include?(@@data)
		end

		def self.quit?
			['q', 'quit', 'exit'].include?(@@data)
		end

		def self.clear?
			['c', 'clear'].include?(@@data)
		end

		clear
	end
end