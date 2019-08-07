local itemsConverter = {
[9383] = {itemid = 2273, charges = 1},
[9384] = {itemid = 2273, charges = 3},

[9385] = {itemid = 2311, charges = 5},
[9386] = {itemid = 2311, charges = 15},

[9387] = {itemid = 2313, charges = 3},
[9388] = {itemid = 2313, charges = 9},

[9389] = {itemid = 2268, charges = 1},
[9390] = {itemid = 2268, charges = 3},

[9391] = {itemid = 2293, charges = 3},
[9392] = {itemid = 2293, charges = 9},

[9393] = {itemid = 2316, charges = 2},

[9395] = {itemid = 2304, charges = 2},
[9396] = {itemid = 2304, charges = 6},

[9397] = {itemid = 2302, charges = 3},

[9415] = {itemid = 2279, charges = 4},

[9415] = {itemid = 9415, charges = 4},

[9407] = {itemid = 2262, charges = 2},

[9409] = {itemid = 2278, charges = 1},
[9410] = {itemid = 2278, charges = 3},

[9411] = {itemid = 2310, charges = 3},

[9413] = {itemid = 2291, charges = 1},

[9417] = {itemid = 2308, charges = 2},

[9429] = {itemid = 2301, charges = 3},

[9419] = {itemid = 2261, charges = 3},

[9421] = {itemid = 2277, charges = 3},

[9423] = {itemid = 2305, charges = 3},

[9425] = {itemid = 2286, charges = 3},

[9427] = {itemid = 2287, charges = 3},


}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local tmp = itemsConverter[item.itemid]

if not tmp then
	return false
end

local backpack = player:addItem(1988)
for i = 1, 20 do
	backpack:addItem(tmp.itemid, tmp.charges)
end

item:remove()
	
return true
end