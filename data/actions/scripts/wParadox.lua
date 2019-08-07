function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid, 8201) ~= 1 then
		if getPlayerFreeCap(cid) < 23 then
			doPlayerSendTextMessage(cid, 22, "You need 23 cap or more to loot this!")
		return true
		end
		doPlayerSendTextMessage(cid, 22, "You have found a yellow spell wand!")
		doPlayerAddItem(cid, 2189, 1)
		setPlayerStorageValue(cid, 8201, 1)		
	else
		doPlayerSendTextMessage(cid, 22, "it's empty.")
	end
	return true
end