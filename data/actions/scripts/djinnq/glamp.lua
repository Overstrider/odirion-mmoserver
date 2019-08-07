function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 17898 then
		if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03) == 3 and doPlayerRemoveItem(cid, 2344, 1) then
			setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03, 4)				
			doSendMagicEffect(toPosition, 29)
			doPlayerAddItem(cid, 2356, 1)
		end
	end
	print(itemEx.actionid)
return true
end