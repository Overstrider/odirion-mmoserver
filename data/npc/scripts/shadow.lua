local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
-- [[ START THE SETTINGS ]] ---
local cfg = {
    outfit = {nome = "Shadow", sto = 32000},
    task = {t = false, key = 0, value = 2, name = "necromancers"},
    itemList = {
        [1] = {id = 6211, count = 50},
        [2] = {id = 5817, count = 50},
        [3] = {id = 6017, count = 50},
        [4] = {id = 6212, count = 50},
    }
}
-- [[ END FROM SETTINGS THINGS ]] ---
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
if (msgcontains(msg:lower(), ''..cfg.outfit.nome:lower()..'')) then
    if getPlayerStorageValue(cid, cfg.outfit.sto) < 1 then
        list = getItemList(cid, cfg.itemList)
        if cfg.task.t then
            selfSay('You have completed the '..cfg.task.name..' mission and wanna give me '..list..'?', cid)
        else
            selfSay('You have '..list..' to trade for the '..cfg.outfit.nome..' outfit?', cid)
        end
        talkState[talkUser] = 1
    else
        selfSay('Sorry but you already can wear this outfit.', cid)
        talkState[talkUser] = 0
    end
   
elseif talkState[talkUser] == 1 then
    if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
        if cfg.task.t then
            if getPlayerStorageValue(cid, cfg.task.key) >= cfg.task.value then
                ctrl = 0
                for i = 1, #cfg.itemList do
                    if getPlayerItemCount(cid, cfg.itemList[i].id) >= cfg.itemList[i].count then
                        ctrl  = ctrl + 1
                    else
                        selfSay('I\'m so sorry, but you don\'t have '..cfg.itemList[i].count..' '..ItemType(cfg.itemList[i].id):getName()..'.', cid)
                        talkState[talkUser] = 0
                        return true
                    end
                    if ctrl == #cfg.itemList then
                        for x = 1, #cfg.itemList do
                            doPlayerRemoveItem(cid, cfg.itemList[x].id, cfg.itemList[x].count)
                        end
                        setPlayerStorageValue(cid, cfg.outfit.sto, 1)
                        selfSay('Congratulations, now you can wear the '..cfg.outfit.nome..' outfit.', cid)
                        talkState[talkUser] = 0
                        return true
                    end
                end
            else
                selfSay('Sorry, but you don\'t have the '..cfg.task.name..' mission.', cid)
                talkState[talkUser] = 0
            end
        else
            ctrl = 0
            for i = 1, #cfg.itemList do
                if getPlayerItemCount(cid, cfg.itemList[i].id) >= cfg.itemList[i].count then
                    ctrl  = ctrl + 1
                else
                    selfSay('I\'m so sorry, but you don\'t have '..cfg.itemList[i].count..' '..ItemType(cfg.itemList[i].id):getName()..'.', cid)
                    talkState[talkUser] = 0
                    return true
                end
                if ctrl == #cfg.itemList then
                    for x = 1, #cfg.itemList do
                        doPlayerRemoveItem(cid, cfg.itemList[x].id, cfg.itemList[x].count)
                    end
                    setPlayerStorageValue(cid, cfg.outfit.sto, 1)
                    selfSay('Congratulations, now you can wear the '..cfg.outfit.nome..' outfit.', cid)
                    return true
                end
            end
        end
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