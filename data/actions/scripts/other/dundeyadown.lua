function onUse(cid, item, frompos, item2, topos)
	if item.actionid==9029 then
		newpos = {x=2088, y=2123, z=10}
		doTeleportThing(cid,newpos)
		return true
	end
end