function onStepIn(cid, item, position, fromPosition)
 if isPlayer(cid) then
   if getPlayerStorageValue(cid, 12120) >= 5 then
       else
       	doPlayerSendTextMessage(cid, 25, "You do not have access! Complete your missions and come back.")
         doTeleportThing(cid, fromPosition, true)
   end
 end
return true
end