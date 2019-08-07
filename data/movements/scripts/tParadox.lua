local increasing = {[416] = 417, [426] = 425, [446] = 447, [3216] = 3217, [3202] = 3215, [11062] = 11063}
local decreasing = {[417] = 416, [425] = 426, [447] = 446, [3217] = 3216, [3215] = 3202, [11063] = 11062}

function onStepIn(creature, item, position, fromPosition)
		item:transform(increasing[item.itemid])
		local Bau = Tile(Position(32479, 31900, 1)):getItemById(1740)
		if Bau then
			Position(32479, 31900, 1):sendMagicEffect(5)
			setPlayerStorageValue(cid, 8202, 1)	
		end
	return true
end
