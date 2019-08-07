local itemsConverter = {
[2273] = {
			[1] = {itemid = 9383},
			[3] = {itemid = 9384}
		 },
[2311] = {
			[5] = {itemid = 9385},
			[15] = {itemid = 9386}
		 },
[2313] = {
			[3] = {itemid = 9387},
			[9] = {itemid = 9388}
		 },
[2268] = {
			[1] = {itemid = 9389},
			[3] = {itemid = 9390}
		 },
[2293] = {
			[3] = {itemid = 9391},
			[9] = {itemid = 9392}
		 },
[2316] = {
			[2] = {itemid = 9391}
		 },
[2304] = {
			[2] = {itemid = 9395},
			[6] = {itemid = 9396}
		 },
[2302] = {
			[3] = {itemid = 9397}
		 },
[2279] = {
			[4] = {itemid = 9415}
		 },		 
[2262] = {
			[2] = {itemid = 9407}
		 },		 
[2278] = {
			[1] = {itemid = 9409},
			[3] = {itemid = 9410}
		 },
[2310] = {
			[3] = {itemid = 9411}
		 },
[2291] = {
			[1] = {itemid = 9413}
		 },
[2308] = {
			[2] = {itemid = 9417}
		 },
[2301] = {
			[3] = {itemid = 9429}
		 },
[2261] = {
			[3] = {itemid = 9419}
		 },
[2277] = {
			[3] = {itemid = 9421}
		 },
[2305] = {
			[3] = {itemid = 9423}
		 },
[2286] = {
			[3] = {itemid = 9425}
		 },
[2287] = {
			[3] = {itemid = 9427}
		 },
}

 
function onUse(cid, item, frompos, item2, topos)
	-- doPlayerSendTextMessage(cid,22,'Rune converter disabled.')
	local itemCharges = getCharges(getContainerItem(item.uid, 0).uid)
	local itemID = getContainerItem(item.uid, 0).itemid
	local containerSize = getContainerSize(item.uid)
	local haveItems = itemsConverter[itemID]
	
	if containerSize == 0 then
		return false
	elseif not haveItems then
		doPlayerSendTextMessage(cid, 22, "It is not possible to make the transformation.")
		doSendMagicEffect(getCreaturePosition(cid), 2, cid)
		return false
	end
	
	if containerSize < 20 then
		doPlayerSendTextMessage(cid, 22, "There are not enough runes for transformation.")
		doSendMagicEffect(getCreaturePosition(cid), 2, cid)
	else
		local verifCharges = itemsConverter[itemID][itemCharges]
		local index = 0
		while index < containerSize - 1 do
			if getCharges(getContainerItem(item.uid, index).uid) ~= itemCharges then
				doPlayerSendTextMessage(cid, 22, "There are different runes inside the container.")
				doSendMagicEffect(getCreaturePosition(cid), 2, cid)
				break
			end
		index = index + 1
		if index == 19 then	
			if getCharges(getContainerItem(item.uid, index).uid) ~= itemCharges then
				doPlayerSendTextMessage(cid, 22, "There are different runes inside the container.")
				doSendMagicEffect(getCreaturePosition(cid), 2, cid)
				return true
			end
			for i = 0, containerSize - 2 do
				local item = getContainerItem(item.uid, 0).uid
				doRemoveItem(item, 1)
			end
			doTransformItem(getContainerItem(item.uid, 0).uid, verifCharges.itemid)
			doSendMagicEffect(getCreaturePosition(cid), 3, cid)
			doPlayerSendTextMessage(cid, 22, "Transformation completed, item "..ItemType(verifCharges.itemid):getName().." was successfully created.")			
		end		
		end
	end
	return false
end