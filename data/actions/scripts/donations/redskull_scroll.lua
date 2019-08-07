function onUse(cid, item, fromPosition, itemEx, toPosition)
	if getCreatureSkullType(cid) == SKULL_RED then
		doCreatureSetSkullType(cid, SKULL_NONE)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations, you have been removed your Red Skull.")
		doRemoveItem(item.uid)
	else
		doPlayerSendCancel(cid, "This item can be use to remove Red Skull only.")
	end
return true
end