require 'io/console'
require_relative 'Stats'

class Player < Stats
	def initialize
		@exp = 0
		@maxxp = 10
		@lvl = 1
		
		@hp = 20
		@maxhp = 20
		@mp = 20
		@maxmp = 20
		
		@at = 6
		@mat = 10
		@heal = 15
	end
	def add(lvl)
		@exp+=lvl
		if @exp >= @maxxp
			self.levelup
			@exp = 0
			@maxxp += 10
			@lvl += 1
		end
	end
	def at
		return @at
	end
	def showstats
		print "Player stats:", "\n"
		print "lvl = ", @lvl, "\n"
		print "exp = ", @exp, " / ", @maxxp, "\n"
		print "hp = ", @hp, " / ", @maxhp,"\n"
		print "mp = ", @mp, " / ", @maxmp, "\n"
		print "at = ", @at, " | ",  "mat = ", @mat," | ", "heal = ", @heal, "\n"
	end
	def levelup
		@hp*=1.5
		@hp = @hp.ceil
		@maxhp*=1.5
		@maxhp = @maxhp.ceil
			
		@at*=1.5
		@at = @at.ceil
		@mat*=1.5
		@mat = @mat.ceil
		@heal*=1.5
		@heal = @heal.ceil
	end
	def mat
		return @mat
	end	
	def heal
		return @heal
	end
	
	def mp_down(x)
		@mp -= x
	end
	def mp_up(x)
	if @mp + x > @maxmp
			@mp = @maxmp
		else
			@mp +=x
		end
	end
	def exhausted(x)
		return @mp - x >= 0
	end
end


class Monster < Stats
	def initialize(lv)
		@lvl = lv
		@hp = 8*lv*1.5
		@hp = @hp.ceil
		@at = 4*lv*1.5
		@at = @at.ceil
	end
	def lvl
		return @lvl
	end
	def showstats
		print "lvl = ", @lvl, "\n"
		print "hp = ", @hp, "\n"
		print "at = ", @at, "\n"
	end
end


class Encounter
	@player
	@monster
	def initialize(player, monster)
		@player = player 
		@monster = monster
		print "Encounter", "\n"
	end
	def give_player
		return @player
	end
	def round
		@player.mp_up(3)
		print "\n", "Monster stats:", "\n"
		@monster.showstats
		puts " "
		print "\n", @player.showstats, "\n"
		print "press A, for attack, press M for magic attack, press H for heal", "\n"
		key=STDIN.getch
		if key == "a" or key == "A"
			@monster.hp_down(@player.at)
		elsif key == "m" or key == "M"
			if @player.exhausted(6)
				@monster.hp_down(@player.mat)
				@player.mp_down(6)
			end
		elsif key == "h" or key == "H"
			if @player.exhausted(4)
				@player.hp_up(@player.heal)
				@player.mp_down(4)
			end
		
		end
		
		if @monster.hp <= 0
			print "You've won", "\n"
			@player.add(@monster.lvl)
			@player.mp_up(10)
			return 1
		else
			@player.hp_down(@monster.at)
		end
		if @player.hp <=0
			print "You've lost", "\n"
			return -1
		end
		return 0
	end
end
