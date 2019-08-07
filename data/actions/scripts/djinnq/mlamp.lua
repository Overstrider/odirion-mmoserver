function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 17899 then
		if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03) == 3 and doPlayerRemoveItem(cid, 2344, 1) then
			setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03, 4)				
			doSendMagicEffect(toPosition, 29)
			doPlayerAddItem(cid,2356,1)
		end
	end
    return true
end