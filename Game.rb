require_relative 'Encounter'
require_relative 'Labirynth'
require 'io/console'

class Game
	def initialize
		@player = Player.new
		@dungeonlevel = 0
	end
	def level
		checklab = 0
		@currentlab = Labirynth.new
		@dungeonlevel+=1
		@currentlab.look
		while checklab == 0
			checklab = @currentlab.movement
			num = rand(9)
			if num == 1
				enc = Encounter.new(@player, Monster.new(@dungeonlevel))
				i = 0
				while i == 0
					i = enc.round
				end
				@player = enc.give_player
				if i == -1
					return -1
				end
				@currentlab.look
				puts
			end
		end
	end
	def dungeon
		while true
			a = self.level
			if a == -1
				break
			end
			puts "If you want to leave, press X"
			key=STDIN.getch
			if key == "x" or key == "X"
				break
			end
		end
	end
end

G=Game.new
G.dungeon
