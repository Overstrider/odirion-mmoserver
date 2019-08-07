-- Player with storage value of the item's actionid set to 1 can open
local opendoor = 1256
function onUse(cid, item, frompos, item2, topos)
	if item.actionid == 51991 and getPlayerStorageValue(cid, 851056) >= 2 then
		if item.itemid ~= opendoor then
			doTransformItem(item.uid, item.itemid+1)
			topos = {x=topos.x, y=topos.y, z=topos.z}
			doTeleportThing(cid,topos)		
		else
			doPlayerSendCancel(cid, 'This door already is opened.')
		end
	else
		doPlayerSendTextMessage(cid,22,'You do not have access! Talk with {Lauder} to enter in Slayer Guild')
	end
	return TRUE
end

