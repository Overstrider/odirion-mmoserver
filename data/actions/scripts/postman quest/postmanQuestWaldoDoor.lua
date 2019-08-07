function onUse(cid, item, fromPosition, itemEx, toPosition)
local player = Player(cid)
	if(item.uid == 3117) then
		if(player:getStorageValue(Storage.postman.Mission08) >= 1) then
			if(item.itemid == 1223) then
				doTeleportThing(cid, toPosition, true)
				doTransformItem(item.uid, item.itemid + 1)
			end
		end
	end
	return true
end