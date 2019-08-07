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
			[2] = {itemid = 9393}
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

 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local backpack = item:getItem(0)
	if backpack ~= nil then
		if isContainer(backpack.uid) then
			return false
		end
		local itemCharges = backpack:getItem(0):getCharges()	
		local itemID = backpack:getItem(0).itemid
		local containerSize = getContainerSize(backpack.uid)
		local haveItems = itemsConverter[itemID]
		
		if containerSize == 0 then
			return false
		elseif not haveItems then
			player:sendTextMessage(22, "It is not possible to make the transformation.")
			player:getPosition():sendMagicEffect(3, player)		
			return false
		end
		
		if containerSize < 20 then		
			player:sendTextMessage(22, "There are not enough runes for transformation.")
			player:getPosition():sendMagicEffect(3, player)
		else
			local verifCharges = itemsConverter[itemID][itemCharges]
			local index = 0
			while index < containerSize - 1 do
				if backpack:getItem(index):getCharges() ~= itemCharges then
					player:sendTextMessage(22, "There are different runes inside the container.")
					player:getPosition():sendMagicEffect(3, player)
					break
				end
			index = index + 1
			if index == 19 then	
				if backpack:getItem(index):getCharges() ~= itemCharges then
					player:sendTextMessage(22, "There are different runes inside the container.")
					player:getPosition():sendMagicEffect(3, player)
					return true
				end
				for i = 0, containerSize - 2 do
					local items = getContainerItem(backpack.uid, 0).uid
					doRemoveItem(items, 1)
				end
				doTransformItem(backpack.uid, verifCharges.itemid)			
				player:getPosition():sendMagicEffect(4, player)
				-- player:sendTextMessage(22, "Transformation completed, item "..target:getName().." was successfully created.")			
			end		
			end
		end
	else
		return true
	end
	return true
end