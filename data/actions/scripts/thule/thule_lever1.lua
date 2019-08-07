function onUse(cid, item, frompos, item2, topos)
	pedrapos2 = {x=33027, y=31264, z=13}
	get = getTileItemById(pedrapos2, 1353).uid
	if get > 0 then
		doRemoveItem(get, 1)
		doSendMagicEffect(pedrapos2, 40)
		addEvent(doCreateItem, 3600*1000, 1353, 1, pedrapos2)
	else
		doPlayerSendCancel(cid, "You need wait to push again.")
		return true
	end 
	if item.itemid == 1945 then
		doTransformItem(item.uid,item.itemid+1)
	elseif item.itemid == 1946 then
		doTransformItem(item.uid,item.itemid-1)
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end
return true
end