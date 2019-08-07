function onUse(cid, item, fromPosition, itemEx, toPosition)
local player = Player(cid)
	if(item.uid == 3119) then
		if(player:getStorageValue(Storage.postman.Mission09) == 1) then
			if(item.itemid == 1225) then
				doTeleportThing(cid, toPosition, true)
				doTransformItem(item.uid, item.itemid + 1)
			end
				else
		doPlayerSendTextMessage(cid,22,'The door is sealed against unwanted intruders.')	
		end
	end
	return true
end