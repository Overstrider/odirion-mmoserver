function onStepIn(cid, item, frompos, item2, topos) 
	wall1 = {x=32266, y=31860, z=11}
	wall2 = {x=32266, y=31861, z=11}	
	getwall1 = getTileItemById(wall1, 1498)
	getwall2 = getTileItemById(wall2, 1285)
	
	if item.actionid == 9994 and getwall1.uid > 0 and getwall2.uid > 0 then
		doRemoveItem(getwall1.uid)
		doRemoveItem(getwall2.uid) 
	end
	return true
end