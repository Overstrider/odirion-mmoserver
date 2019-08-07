local corpseact = 21012
local SKINS = {
    -- Abomination Arms  [OK]
    [5683] = {chance = 9, reward = 5796},
 
    -- Dragon Green leather [OK]
    [3104] = {chance = 9, reward = 5797},

    -- Larva eggs [OK]
    [5861] = {chance = 9, reward = 6005},

    -- Orc Theets todos orcs Ber, Lead, Warrior [OK]
    [5864] = {chance = 9, reward = 5870},
    [5867] = {chance = 9, reward = 5870},
    [6032] = {chance = 9, reward = 5870},
    [5855] = {chance = 9, reward = 5870},
    [5871] = {chance = 9, reward = 5870},
    [5874] = {chance = 9, reward = 5870},
    [5926] = {chance = 9, reward = 5870},

    -- Leather Beater Orc Warrior [OK]
    [5852] = {chance = 9, reward = 5877},

    -- Hydra claw Lern Hydra 
    [6305] = {chance = 9, reward = 6224},
     
     -- Rabbit Ears Orelha [OK]
    [2992] = {chance = 9, reward = 6006},

     -- Red Dragon Leather [OK]
    [2881] = {chance = 9, reward = 6007},

    -- Chimera Mane [OK]
    [5947] = {chance = 9, reward = 6111},

    -- Corrupted spider fang
    [5914] = {chance = 9, reward = 6113},

    -- wight brain
    [5680] = {chance = 9, reward = 6212},

    -- Minotaur brown leather [OK]
    [2830] = {chance = 9, reward = 6215},
    [2876] = {chance = 9, reward = 6215},
    [2866] = {chance = 9, reward = 6215},
    [2871] = {chance = 9, reward = 6215},
    [5911] = {chance = 9, reward = 6215},
    [5908] = {chance = 9, reward = 6215},
    [5905] = {chance = 9, reward = 6215},
 
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