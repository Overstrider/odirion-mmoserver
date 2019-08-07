function onStepIn(cid, item, position, fromPosition)   
	DHPISOTWOPLAYER = DHPISOTWOPLAYER + 1
	doTransformItem(item.uid, item.itemid - 1)   
end

function onStepOut(cid, item, position, fromPosition) 
	DHPISOTWOPLAYER = DHPISOTWOPLAYER - 1
	doTransformItem(item.uid, item.itemid + 1)
end