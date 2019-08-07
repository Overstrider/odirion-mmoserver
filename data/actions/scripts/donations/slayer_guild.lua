function onUse(cid, item, itemEx, toPosition)
 
local pos = getCreaturePosition(cid)
if (getTilePzInfo(getPlayerPosition(cid)) == FALSE) then
if(getPlayerStorageValue(cid, 51980) == 2) then
doPlayerSendTextMessage(cid, 22, "You already have Slayer Guild Acess!")
else
doRemoveItem(item.uid, 1)
setPlayerStorageValue(cid, 51980, 47)
doPlayerSendTextMessage(cid, 22, "You now have access to Slayer Guild!")
end
else
doPlayerSendTextMessage(cid, 22, "You can only use this item inside protection zone!")
end
return true
end