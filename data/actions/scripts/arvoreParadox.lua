function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid,8192) <= 0 then
		if getPlayerFreeCap(cid) <= 1 then
			doPlayerSendTextMessage(cid,22,"You need 1 cap or more to loot this!")
		return true
		end
		doPlayerSendTextMessage(cid,22,"You have found a key!")
		KEY = doPlayerAddItem(cid,2089,1)
		doSetItemActionId(KEY,2044)
		doSetItemSpecialDescription(KEY,"(Key: 3899)")
		setPlayerStorageValue(cid,8192,1)		
	else
	doPlayerSendTextMessage(cid,22,"it's empty.")
	return true
	end
	return true
end