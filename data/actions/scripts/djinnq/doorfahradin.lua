local storage = 100064
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(getPlayerStorageValue(cid, storage) >= 7) then
		doTransformItem(item.uid, item.itemid + 1)
		doTeleportThing(cid, toPosition, true)		
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This door seems to be sealed against unwanted intruders2.")
	end
return true
end