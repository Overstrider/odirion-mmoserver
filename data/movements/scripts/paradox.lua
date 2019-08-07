local wallPositions = {
	Position(32497, 31888, 7),
	Position(32497, 31889, 7),
	Position(32497, 31890, 7),
	Position(32498, 31890, 7),
	Position(32499, 31890, 7),
	Position(32496, 31890, 7),
}

function onStepIn(creature, item, position, fromPosition)
		local creature = Tile(wallPositions[1]):getTopCreature()
		if not creature or not creature:isPlayer() then
			return true
		end	
	doTargetCombatHealth(0, creature, COMBAT_EARTHDAMAGE, -200, -200, CONST_ME_NONE)	
	for i = 2, #wallPositions do
		addEvent(Game.createItem, 100, 1490, 1, wallPositions[i])
	end
	return true
end
