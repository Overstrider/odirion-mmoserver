local corpseact = 21012
local SKINS = {
    -- Beholder  [OK]
    [2908] = {chance = 15, reward = 5778},
 
    -- Black Sheep [OK]
    [2914] = {chance = 15, reward = 5779},
 
    -- Dwarf Beard [OK]
    [2960] = {chance = 15, reward = 5780},
 
    -- Elf Ear [OK]
    [2945] = {chance = 15, reward = 5781},
 
    -- Tear of Nature [OK]
    [2979] = {chance = 15, reward = 5782},
 
    -- Fire devil [OK]
    [6035] = {chance = 15, reward = 5783},
 
    -- Blue hair Frost Troll [OK]
    [2928] = {chance = 15, reward = 5784},
 
    -- Lion mane  [OK]
    [5849] = {chance = 15, reward = 5785},
 
    -- Minotaur horn all minos [OK]
    [2830] = {chance = 15, reward = 5786},
    [2866] = {chance = 15, reward = 5786},
    [2876] = {chance = 15, reward = 5786},
    [2871] = {chance = 15, reward = 5786},
 
    -- Orc warrior iron piece [OK]
    [6039] = {chance = 15, reward = 5787},
 
    -- patch of orc skin [OK]
    [6032] = {chance = 15, reward = 5788},
 
    -- orc spearman blue bear [OK]
    [5855] = {chance = 15, reward = 5789},
 
    -- Pig tail Pig [OK]
    [2935] = {chance = 15, reward = 5790},
 
    -- Sheep Wool [OK]
    [2905] = {chance = 15, reward = 5791},
 
    -- Snake Tongue [OK]
    [2817] = {chance = 15, reward = 5792},
 
    -- Spider reaming [OK]
    [2807] = {chance = 15, reward = 5793},
 
    -- swamp troll [OK]
    [5858] = {chance = 15, reward = 5794},
 
    -- troll [OK]
    [2806] = {chance = 15, reward = 5795},
 
    -- Orc Bowman [OK]
    [5926] = {chance = 15, reward = 5787},
 
    -- Minotaur Gladiator [OK]
    [5908] = {chance = 15, reward = 5786},
 
    -- Minotaur Furious [Ok]
    [5911] = {chance = 15, reward = 5786},
 
    --Minotaur Leader [Ok]
    [5905] = {chance = 15, reward = 5786},
}
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
    local skin = SKINS[itemEx.itemid]
    if not skin then
        doGetSkinOnBorder(cid, getThingPos(itemEx.uid))
        return true
    end
    getAction = itemEx.actionid
    if getAction == corpseact then
        doPlayerSendCancel(cid, "You can't use this item in a summon corpse.")
    return true
    end
    local random = math.random(1, 100)
    local effect = CONST_ME_GROUNDSHAKER
    if random <= skin.chance then
        doPlayerAddItem(cid, skin.reward, 1)
    else
        effect = CONST_ME_POFF
    end
    doSendMagicEffect(toPosition, effect)
	
    itemEx:transform(itemEx.itemid + 1)	
    return true
end

function doGetSkinOnBorder(cid, pos)
	for index, result in pairs(SKINS) do
		get = getTileItemById(pos, index) 
		if get.uid > 0 then
			local skin = SKINS[get.itemid]
			getAction = get.actionid
			if getAction == corpseact then
				doPlayerSendCancel(cid, "You can't use this item in a summon corpse.")
			return true
			end
			local random = math.random(1, 100)
			local effect = CONST_ME_GROUNDSHAKER
			if random <= skin.chance then
				doPlayerAddItem(cid, skin.reward, 1)
			else
				effect = CONST_ME_POFF
			end
			doSendMagicEffect(pos, effect)
			
			itemEx:transform(itemEx.itemid + 1)			
			return true
		end
	end
end