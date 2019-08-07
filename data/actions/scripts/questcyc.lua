function onUse(cid, item, frompos, item2, topos)
local gatepos1 = Position(32225, 32276, 8)
local getgate1 = getThingfromPos(gatepos1)

	
if item.itemid == 1945 then	
doTransformItem(getgate1.uid, 369)
doTransformItem(item.uid,1946)
elseif item.itemid == 1946 then
doTransformItem(getgate1.uid, 354)
doTransformItem(item.uid,1945)
end
	return true
end