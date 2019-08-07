function onUse(cid, item, frompos, item2, topos)
if item.uid == 9431 then
  queststatus = getPlayerStorageValue(cid,9431)
  if queststatus == -1 or queststatus == 0 then
  if getPlayerFreeCap(cid) <= 13 then
doPlayerSendTextMessage(cid,22,"You need 13 cap or more to loot this!")
return TRUE
end
   doPlayerSendTextMessage(cid,22,"You have found a monk diary.")
   item_uid = doPlayerAddItem(cid,9431,1)
   setPlayerStorageValue(cid,9431,1)

  else
   doPlayerSendTextMessage(cid,22,"it\'s empty.")
  end
else
  return 0
end
return 1
end

