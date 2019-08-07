function onUse(cid, item, fromPosition, itemEx, toPosition)
local player = Player(cid)
	if(item.uid == 3120) then
		if(player:getStorageValue(Storage.postman.Mission09) == 1) then
			if(getPlayerFreeCap(cid) >= 500) then
				player:setStorageValue(Storage.postman.Mission09, 2)
				doPlayerAddItem(cid, 2330, 1)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You've found a letterbag.")
			else
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You don't have enought capacity. The letterbag weights 500 oz.")
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	elseif(item.itemid == 2330) then
		if(itemEx.actionid == 7816 and itemEx.itemid == 2334) then
			if player:getStorageValue(Storage.postman.Mission09) == 2 then
			player:setStorageValue(Storage.postman.Mission09, 3)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			item:transform(1993)
		end
		end
	end
	return true
end