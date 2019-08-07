function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if(item.itemid == 2416 and itemEx.actionid == 7815 and itemEx.itemid == 2593) then
		if player:getStorageValue(Storage.postman.Mission02) == 1 then
			player:setStorageValue(Storage.postman.Mission02, 2)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end
	end	
	return true
end