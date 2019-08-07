function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid, 8200) ~= 1 then
		if getPlayerFreeCap(cid) < 10 then
			doPlayerSendTextMessage(cid, 22, "You need 10 cap or more to loot this!")
		return true
		end
		doPlayerSendTextMessage(cid, 22, "You have found 100 platinum coins!")
		doPlayerAddItem(cid, 2152, 100)
		setPlayerStorageValue(cid, 8200, 1)		
	else
		doPlayerSendTextMessage(cid, 22, "it's empty.")
	end
	return true
end