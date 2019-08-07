function onUse(cid, item, fromPosition, itemEx, toPosition)

    if not getPlayerBlessing(cid, 5) then
	for i = 1, 5 do
		doPlayerAddBlessing(cid, i)
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have received all blessings.")
	doRemoveItem(item.uid)
    else
	doPlayerSendCancel(cid, "You already have all blessings.")
    end
end