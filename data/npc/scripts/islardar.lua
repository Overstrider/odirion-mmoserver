local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
-- [[ START THE SETTINGS ]] ---
local travel = {storage = 851016, name = "Islardar", cost = 200, destiny = {x=1568, y=2145, z=6}}
-- [[ END FROM SETTINGS THINGS ]] ---
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
if (msgcontains(msg, 'islardar') or msgcontains(msg, 'travel')) then
    selfSay('You really travel to {'..travel.name..'} for '..travel.cost..' gps?', cid)
    talkState[talkUser] = 1
   
    -- [[ CONFIRMANDO BROADCASTMESSAGES ]] --
elseif talkState[talkUser] == 1 then
    if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
        if getPlayerStorageValue(cid, travel.storage) >= 1 then
            if doPlayerRemoveMoney(cid, travel.cost) then
                doTeleportThing(cid, travel.destiny)
                selfSay('Alright, see you soon.', cid)
                talkState[talkUser] = 0
            else
                selfSay('Sorry, but you don\'t have money.', cid)
                talkState[talkUser] = 0
            end
        else
            selfSay('Sorry, but you don\'t have the Orc task for travel.', cid)
            talkState[talkUser] = 0
        end
    else
        selfSay('Okay, see u later.', cid)
        talkState[talkUser] = 0
    end
   
end
  return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())