function onUse(cid, item, frompos, item2, topos)
	local pos = getCreaturePosition(cid)
	if getTilePzInfo(pos) then
		if isPremium(cid) then
			if getPromotedVocation(getPlayerVocation(cid)) == 0 then
				doPlayerSendCancel(cid, "You already been promoted before.")
				doSendMagicEffect(pos, CONST_ME_POFF)
			else
				doRemoveItem(item.uid, 1) -- remove o promotion scroll
				doPlayerSetVocation(cid, getPromotedVocation(getPlayerVocation(cid)))
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations, you have been promoted.")
				doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
			end
		else
			doPlayerSendCancel(cid, "This item just can be used by Premium Accounts.")
		end
	else
		doPlayerSendCancel(cid, "This item just can be used on protect zone.")
	end
return true
end