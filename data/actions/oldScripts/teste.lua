function getStatSlots(item)
	local t = {}
	for _ in item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION):gmatch('(%[.-%])') do
		if _ then
			if _:match('%[(.+)%]') then
				local n = _:match('%[(.+)%]')
				if n ~= '?' then
					local n1 = n:split("+")
					local i = #t + 1
					t[i] = {n1[1], n1[2]}
				end
			end
		end
	end
	return t
end

function getStatSlotCount(item)
	local c = 0
	for _ in item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION):gmatch('%[(.-)%]') do
		c = c+1
	end
	return c
end

function addStatSlot(item, spell, val, suffix)
	if spell and val then
		if not suffix then suffix = "" end
		-- if getStatSlotCount(item) == 0 then
		desc = item:getType():getDescription()
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "[" .. spell .. "" .. (val >= 0 and "+" .. val or val) .. suffix .. "]\n" ..desc)
		-- end
	else
		return false
	end
return true
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	-- doItemSetAttribute(itemEx.uid, "extradefense", "1")
	
	
	-- item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "[Fire + 5]")
	
	addStatSlot(item, "Fire", 5, "")
	
	-- for k, v in pairs(getStatSlots(item)) do
		-- print(v[1])
		-- print(v[2])
	-- end
	-- itemEx:transform(2160)
	-- doItemEraseAttribute(itemEx.uid, "description")
	-- itemEx:transform(2392)	
	-- itemEx:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, itemEx:getType():getDescription())
	return true
end