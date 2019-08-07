function onUse(cid, item, frompos, item2, topos)
	local list = ""
	local containerSize = getContainerSize(item.uid)
	local index = 0
	while index < containerSize do
		local name = getItemInfo(getContainerItem(item.uid, index).itemid)
	index = index + 1
	end
	-- doSendPlayerExtendedOpcode(cid, 151, list)
	return false
end