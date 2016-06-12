class Stats

	def hp_up(x)
		if @hp + x > @maxhp
			@hp = @maxhp
		else
			@hp +=x
		end
	end
	def hp_down(x)
		@hp -= x
	end
	def hp
		return @hp
	end
	def at
		return @at
	end

end
