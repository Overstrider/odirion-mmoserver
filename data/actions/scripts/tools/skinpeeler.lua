local corpseact = 21012
local SKINS = {
    -- Abominated Skin Piece [OK]
     [5683] = {chance = 12, reward = 6008},
 
    -- Bear Paw [OK]
    [5878] = {chance = 12, reward = 6009},
    -- Behemoth Horn [OK]
    [2931] = {chance = 12, reward = 6010},

    -- Cifre de deer [OK]
    [2835] = {chance = 12, reward = 6011},

    -- Firedevil Claw [OK]
    [6035] = {chance = 12, reward = 6012},

    -- Lich Skull [OK]
    [6220] = {chance = 12, reward = 6211},

    -- Patch of armor steel [OK]
    [3065] = {chance = 12, reward = 6219},

    -- Glob of tar [OK]
    [5965] = {chance = 12, reward = 6223},

     -- Demon Claw [OK]
    [2916] = {chance = 12, reward = 6013},

    -- Dog head [OK]
    [2839] = {chance = 12, reward = 5807},

    -- Giant spider head [OK]
    [2857] = {chance = 12, reward = 5808},

    -- Minotaur head [OK]
    [2830] = {chance = 12, reward = 5809},
    [2876] = {chance = 12, reward = 5809},
    [2866] = {chance = 12, reward = 5809},
    [2871] = {chance = 12, reward = 5809},
    [5911] = {chance = 12, reward = 5809},
    [5908] = {chance = 12, reward = 5809},
    [5905] = {chance = 12, reward = 5809},

    -- Nether Spider Head [OK]
    [5764] = {chance = 12, reward = 5810},

    -- Orc Head  [OK]
    [6032] = {chance = 12, reward = 5811},
    [5852] = {chance = 12, reward = 5811},
    [6042] = {chance = 12, reward = 5811},
    [5871] = {chance = 12, reward = 5811},
    [5864] = {chance = 12, reward = 5811},
    [5867] = {chance = 12, reward = 5811},
    [5874] = {chance = 12, reward = 5811},
    [5926] = {chance = 12, reward = 5811},

    -- Polar paw [OK]
    [5881] = {chance = 12, reward = 5812},

    -- Rotworm [OK]
    [2824] = {chance = 12, reward = 6014},

    -- Scorpion Tail [OK]
    [5884] = {chance = 12, reward = 6015},

    -- Skeleton [OK]
    [2843] = {chance = 12, reward = 6016},

    -- Wolf Paw [OK]
    [2826] = {chance = 12, reward =  6017},

    -- Winter wolf paw [OK]
    [2924] = {chance = 12, reward = 5817},

    -- War wolf paw [OK]
    [2969] = {chance = 12, reward = 5818},

    -- Corrupted spider [Ok]
    [5914] = {chance = 12, reward = 6112},

    -- Hyena Fangs [Ok]
    [3019] = {chance = 12, reward = 6213},



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