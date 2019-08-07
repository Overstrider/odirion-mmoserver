-- Including the Advanced NPC System
dofile('data/npc/lib/npcsystem/npcsystem.lua')
dofile('data/npc/lib/npcsystem/customModules.lua')

function msgcontains(message, keyword)
	local message, keyword = message:lower(), keyword:lower()
	if message == keyword then
		return true
	end

	return message:find(keyword) and not message:find('(%w+)' .. keyword)
end

function doNpcSellItem(cid, itemid, amount, subType, ignoreCap, inBackpacks, backpack)
	local amount, subType, ignoreCap, inBackpacks, backpack  = amount or 1, subType or 0, ignoreCap or true, inBackpacks or false, backpack or 1988

	-- local exhaustionNPC = getBooleanFromString(getConfigValue('exhaustionNPC'))
	-- if(exhaustionNPC) then
		-- local exhaustionInSeconds = getConfigValue('exhaustionInSecondsNPC')
		-- local storage = 45814
		-- if(exhaustion.check(cid, storage) == true) then
			-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You cant buy it so fast.")
			-- return false
		-- end
		-- exhaustion.set(cid, storage, exhaustionInSeconds)
	-- end

	local item, a = nil, 0
	if(inBackpacks) then
		local custom, stackable = 1, isItemStackable(itemid)
		if(stackable) then
			custom = math.max(1, subType)
			subType = amount
			amount = math.max(1, math.floor(amount / 100))
		end

		local container, b = doCreateItemEx(backpack, 1), 1
		for i = 1, amount * custom do
			item = doAddContainerItem(container, itemid, subType)
			if(itemid == ITEM_PARCEL) then
				doAddContainerItem(item, ITEM_LABEL)
			end

			if(isInArray({(getContainerCapById(backpack) * b), amount}, i)) then
				if(doPlayerAddItemEx(cid, container, ignoreCap) ~= RETURNVALUE_NOERROR) then
					b = b - 1
					break
				end

				a = i
				if(amount > i) then
					container = doCreateItemEx(backpack, 1)
					b = b + 1
				end
			end
		end

		if(not stackable) then
			return a, b
		end

		return (a * subType / custom), b
	end

	if(isItemStackable(itemid)) then
		a = amount * math.max(1, subType)
		repeat
			local tmp = math.min(100, a)
			item = doCreateItemEx(itemid, tmp)
			if(doPlayerAddItemEx(cid, item, ignoreCap) ~= RETURNVALUE_NOERROR) then
				return 0, 0
			end

			a = a - tmp
		until a == 0
		return amount, 0
	end

	for i = 1, amount do
		item = doCreateItemEx(itemid, subType)
		if(itemid == ITEM_PARCEL) then
			doAddContainerItem(item, ITEM_LABEL)
		end

		if(doPlayerAddItemEx(cid, item, ignoreCap) ~= RETURNVALUE_NOERROR) then
			break
		end

		a = i
	end

	return a, 0
end

local func = function(cid, text, type, e, pcid)
	if isPlayer(pcid) then
		doCreatureSay(cid, text, type, false, pcid, getCreaturePosition(cid))
		e.done = true
	end
end

function doCreatureSayWithDelay(cid, text, type, delay, e, pcid)
	if isPlayer(pcid) then
		e.done = false
		e.event = addEvent(func, delay < 1 and 1000 or delay, cid, text, type, e, pcid)
	end
end

function doPlayerTakeItem(cid, itemid, count)
	if getPlayerItemCount(cid,itemid) < count then
		return false
	end

	while count > 0 do
		local tempcount = 0
		if isItemStackable(itemid) then
			tempcount = math.min (100, count)
		else
			tempcount = 1
		end

		local ret = doPlayerRemoveItem(cid, itemid, tempcount)
		if ret ~= false then
			count = count - tempcount
		else
			return false
		end
	end

	if count ~= 0 then
		return false
	end
	return true
end

function doPlayerSellItem(cid, itemid, count, cost)
	if doPlayerTakeItem(cid, itemid, count) == true then
		if not doPlayerAddMoney(cid, cost) then
			error('Could not add money to ' .. getPlayerName(cid) .. '(' .. cost .. 'gp)')
		end
		return true
	end
	return false
end

function doPlayerBuyItemContainer(cid, containerid, itemid, count, cost, charges)
	if not doPlayerRemoveMoney(cid, cost) then
		return false
	end

	for i = 1, count do
		local container = doCreateItemEx(containerid, 1)
		for x = 1, getContainerCapById(containerid) do
			doAddContainerItem(container, itemid, charges)
		end

		if doPlayerAddItemEx(cid, container, true) ~= RETURNVALUE_NOERROR then
			return false
		end
	end
	return true
end

function getCount(string)
	local b, e = string:find("%d+")
	return b and e and tonumber(string:sub(b, e)) or -1
end
