function onUse(cid, item, fromPosition, item2, toPosition)
local teleport = {x=2008, y=1963, z=14} -- Coordenadas para onde o player irá ser teleportado.
local item_id = 6007 -- ID do item que o player precisa para ser teleportado.
if getPlayerItemCount(cid,item_id) >= 1 then
	doPlayerRemoveItem(cid, 6007, 1)
doTeleportThing(cid, teleport)
doSendMagicEffect(getPlayerPosition(cid), 10)
doPlayerSendTextMessage(cid, 22, "Ok, let's go! You sacrificed your "..ItemType(item_id):getName().." for make this quest!")
else
doPlayerSendTextMessage(cid, 23, "Sorry, you need a "..ItemType(item_id):getName().." to enter.")
end
end