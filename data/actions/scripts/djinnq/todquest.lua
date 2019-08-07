function onUse(cid, item, frompos, item2, topos)
if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02) == 2 then
	setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02, 3)
	doPlayerSendTextMessage(cid, 25, "You have found tear of drama.")
	doPlayerAddItem(cid, 2346, 1) 
	setPlayerStorageValue(cid, 100062, 7)
else
	doPlayerSendTextMessage(cid, 25, "The chest is empty.")
end
return true
end 