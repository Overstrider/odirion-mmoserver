function onUse(cid, item, fromPosition, itemEx, toPosition)
 
		 if getPlayerStorageValue(cid,33000) == -1 then
		 doPlayerSendTextMessage(cid,21,"You won the Outfits of Royal Warrior")
		 setPlayerStorageValue(cid,33000,1)
		 doSendMagicEffect(getCreaturePosition(cid), math.random(1, 67))
		 doRemoveItem(item.uid)
		else
			doPlayerSendTextMessage(cid,25,"You already have this Outfit.")
		end
	return TRUE
end