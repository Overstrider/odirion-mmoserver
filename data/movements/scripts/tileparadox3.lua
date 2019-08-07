local positions = {
	Position(33190, 31629, 13),
	Position(33191, 31629, 13)
}

function onStepIn(creature, item, position, fromPosition)
		local Pedra = Tile(Position(32478, 31902, 7)):getItemById(1304)
		local Escada = Tile(Position(32478, 31902, 7)):getItemById(1385)
		local grama = Tile(Position(32477, 31906, 7)):getItemById(2782)
		if Pedra and grama then
				Pedra:remove()
				addEvent(Game.createItem, 1, 1385, 1, Position(32478, 31902, 7))
				addEvent(function()
							local Escada = Tile(Position(32478, 31902, 7)):getItemById(1385)
							  Escada:remove()
						   end, 10 * 1000)
				addEvent(Game.createItem, 10 * 1000, 1304, 1, Position(32478, 31902, 7))
		end
	return true
end
