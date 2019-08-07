function onStepIn(creature, item, position, fromPosition)
		local Escada = Tile(Position(32478, 31904, 5)):getItemById(1386)
		if Escada then
		
		else
			Game.createItem(1386, 1, Position(32478, 31904, 5))
		end
	return true
end
