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
    outfit = {nome = "enter guild" or "Enter Guild", sto = 51980},
    task = {t = false, key = 0, value = 2, name = "necromancers"},
    itemList = {
        [1] = {id = 7134, count = 5},
    }
}
-- [[ END FROM SETTINGS THINGS ]] ---
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
if (msgcontains(msg:lower(), ''..cfg.outfit.nome:lower()..'')) then
    if getPlayerStorageValue(cid, cfg.outfit.sto) < 2 then
        list = getItemList(cid, cfg.itemList)
        if cfg.task.t then
            selfSay('You have completed the '..cfg.task.name..' mission and wanna give me '..list..'?', cid)
        else
            selfSay('Would you have '..list..' to release access to the slayer guild for you? ', cid)
        end
        talkState[talkUser] = 1
    else
        selfSay('Sorry, but you are already part of the Slayer Guild Member.', cid)
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
                        setPlayerStorageValue(cid, cfg.outfit.sto, 2)
                        selfSay('Congratulations, you can now pass a door next to you to Enter Slayer Guild Task', cid)
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
                    selfSay('I\'m so sorry, but you don\'t have '..cfg.itemList[i].count..' '..getItemDescriptions(cfg.itemList[i].id).name..'.', cid)
                    talkState[talkUser] = 0
                    return true
                end
                if ctrl == #cfg.itemList then
                    for x = 1, #cfg.itemList do
                        doPlayerRemoveItem(cid, cfg.itemList[x].id, cfg.itemList[x].count)
                    end
                    setPlayerStorageValue(cid, cfg.outfit.sto, 2)
                    selfSay('Congratulations, you can now pass a door next to you to Enter Slayer Guild Task ', cid)
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