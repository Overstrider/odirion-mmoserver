function onUse(cid, item, fromPosition, itemEx, toPosition)
local player = Player(cid)
	if(item.uid == 3118) then
		if(player:getStorageValue(Storage.postman.Mission08) == 1) then
			player:setStorageValue(Storage.postman.Mission08, 2)
			doPlayerAddItem(cid, 2332, 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You've found a post horn.")
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end