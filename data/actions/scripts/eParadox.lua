function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid, 8203) ~= 1 then
		if getPlayerFreeCap(cid) < 7 then
			doPlayerSendTextMessage(cid, 22, "You need 7 cap or more to loot this!")
		return true
		end
		doPlayerSendTextMessage(cid, 22, "You have egg!")
		doPlayerAddItem(cid, 6488, 1)
		setPlayerStorageValue(cid, 8203, 1)		
	else
		doPlayerSendTextMessage(cid, 22, "it's empty.")
	end
return true
end