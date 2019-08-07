local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local vocation = {}
local town = {}
local cityTable = nil
local vocationTable = nil

 
local config = {
    level = {8, 9}, -- mínimo, máximo
    towns = {
        ["venore"] = 4,
        ["thais"] = 3,
        ["carlin"] = 5
    },
 
    vocations = {
        ["sorcerer"] = {
            text = "A SORCERER! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
            vocationId = 1,
        },
 
        ["druid"] = {
            text = "A DRUID! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
            vocationId = 2,
        },
 
        ["paladin"] = {
            text = "A PALADIN! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
            vocationId = 3,
        },
 
        ["knight"] = {
            text = "A KNIGHT! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
            vocationId = 4,
        }
    }
}

local function getTownListName(cid)
    list = ''
    for index, result in pairs(config.towns) do
        if list == '' then
            list = '{'..index..'}'
        else
            list = ''..list..' or {'..index..'}'
        end
    end
    return list
end
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
local function greetCallback(cid)
    local player = Player(cid)
    local level = player:getLevel()
    if level < config.level[1] then
        npcHandler:say("CHILD! COME BACK WHEN YOU HAVE GROWN UP! [Needs level "..config.level[1].."]", cid)
        return false
    elseif level > config.level[2] then
        npcHandler:say(player:getName() ..", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! YOU CAN ONLY LEAVE WITH LEVEL 9 OR LOWER.", cid)
        return false
    elseif player:getVocation():getId() > 0 then
        npcHandler:say("YOU ALREADY HAVE A VOCATION!", cid)
        return false
    else
        npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", ARE YOU PREPARED TO FACE YOUR DESTINY?")
    end
    return true
end
 
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
 
    local player = Player(cid)
    if npcHandler.topic[cid] == 0 then
        if msgcontains(msg, "yes") then
            list = getTownListName(cid)
            npcHandler:say("IN WHICH TOWN DO YOU WANT TO LIVE: "..string.upper(list).."?", cid)
            npcHandler.topic[cid] = 1
        end
    elseif npcHandler.topic[cid] == 1 then
        cityTable = config.towns[string.lower(msg)]
        if cityTable then
            town[cid] = cityTable
            npcHandler:say("IN ".. string.upper(msg) .."! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
            npcHandler.topic[cid] = 2
        else
            list = getTownListName(cid)
            npcHandler:say("IN WHICH TOWN DO YOU WANT TO LIVE: "..string.upper(list).."?", cid)
        end
    elseif npcHandler.topic[cid] == 2 then
        vocationTable = config.vocations[string.lower(msg)]
        if vocationTable then
            npcHandler:say(vocationTable.text, cid)
            npcHandler.topic[cid] = 3
            vocation[cid] = vocationTable.vocationId
        else
            npcHandler:say("{KNIGHT}, {PALADIN}, {SORCERER} OR {DRUID}?", cid)
        end
    elseif npcHandler.topic[cid] == 3 then
        if msgcontains(msg, "yes") then
            npcHandler:say("SO BE IT!", cid)
			print(vocation[cid].."Vocacao")
			print(town[cid].."Cidade")
            player:setVocation(Vocation(vocation[cid]))
            player:setTown(Town(town[cid]))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:teleportTo(getTownTemplePosition(getPlayerTown(cid)))
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            npcHandler:say("THEN WHAT? {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
            npcHandler.topic[cid] = 2
        end
    end
    return true
end
 
local function onAddFocus(cid)
    town[cid] = 0
    vocation[cid] = 0
end
 
local function onReleaseFocus(cid)
    town[cid] = nil
    vocation[cid] = nil
end
 
npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
 
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())