local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
-- [[ START THE SETTINGS ]] ---
local outfit = {storage = 38000, name = "Warrior Cape"}
local stoList = {
    [1] = {key = 851030, value = 2, mission = "Black Knights Task"},
    [2] = {key = 8017, value = 1, mission = "Black Knight Quest"},
    [3] = {key = 8016, value = 1, mission = "Black Knight Quest"},
}
-- [[ END FROM SETTINGS THINGS ]] ---
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
if (msgcontains(msg, 'outfit') or msgcontains(msg, 'warrior cape')) then
    selfSay('To activate this outfit you need the complete black knight task and the complete black knight quest, did you complete all that I mentioned?', cid)
    talkState[talkUser] = 1
   
    -- [[ CONFIRMANDO BROADCASTMESSAGES ]] --
elseif talkState[talkUser] == 1 then
    if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
        for a = 1, #stoList do
            if getPlayerStorageValue(cid, stoList[a].key) < stoList[a].value then
                selfSay('I\'m so sorry, but you don\'t have the '..stoList[a].mission..'.', cid)
                talkState[talkUser] = 0
            return true
            end
        end
        setPlayerStorageValue(cid, outfit.storage, 1)
        selfSay('Congratulations, you have active the '..outfit.name..' outfit.', cid)
        talkState[talkUser] = 0
    else
        selfSay('Okay, see u later.', cid)
        talkState[talkUser] = 0
    end
   
end
  return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())