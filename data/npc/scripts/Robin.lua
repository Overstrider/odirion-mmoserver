local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
-- [[ START THE SETTINGS ]] ---
local knives = {
    ["hunter knife"] = {id = 5775, count = 5000},
    ["skinpeeler knife"] = {id = 5777, tradeid = 5786, tradecount = 100},
    ["skinning knife"] = {id = 5776, tradeid = 6012, tradecount = 100},
}
-- [[ END FROM SETTINGS THINGS ]] ---
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    knife = knives[msg]
    if knife then
        if knife.id == 5775 then
            selfSay('You really wanna buy the '..msg..' for '..knife.count..' gold coins?', cid)
            talkState[talkUser] = 1
        elseif knife.id == 5776 then
            selfSay('You really wanna trade '..knife.tradecount..' '..ItemType(knife.tradeid):getName()..' for a '..msg..'?', cid)
            talkState[talkUser] = 2
        elseif knife.id == 5777 then
            selfSay('You really wanna trade '..knife.tradecount..' '..ItemType(knife.tradeid):getName()..' for a '..msg..'?', cid)
            talkState[talkUser] = 3
        end
       
       
        -- [[ CONFIRMANDO BROADCASTMESSAGES ]] --
    elseif talkState[talkUser] == 1 then
        if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
            if doPlayerRemoveMoney(cid, knives["hunter knife"].count) then
                doPlayerAddItem(cid, knives["hunter knife"].id, 1)
                selfSay('Here are your item.', cid)
            else
                selfSay('Sorry, but you don\'t have '..knives["hunter knife"].count..' gold coins.', cid)
                talkState[talkUser] = 0
            end
        else
            selfSay('Okay, see u later.', cid)
            talkState[talkUser] = 0
        end
       
    elseif talkState[talkUser] == 2 then
        if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
            if getPlayerItemCount(cid, knives["skinning knife"].tradeid) >= knives["skinpeeler knife"].tradecount then
                doPlayerRemoveItem(cid, knives["skinning knife"].tradeid, knives["skinning knife"].tradecount)
                doPlayerAddItem(cid, knives["skinning knife"].id, 1)
                selfSay('Here are your item.', cid)
                talkState[talkUser] = 0
            else
                selfSay('Sorry, but you don\'t have '..knives["skinning knife"].tradecount..' '..ItemType(knives["skinning knife"].tradeid):getName()..'s.', cid)
                talkState[talkUser] = 0
            end
        else
            selfSay('Okay, see u later.', cid)
            talkState[talkUser] = 0
        end
       
    elseif talkState[talkUser] == 3 then
        if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
            if getPlayerItemCount(cid, knives["skinpeeler knife"].tradeid) >= knives["skinpeeler knife"].tradecount then
                doPlayerRemoveItem(cid, knives["skinpeeler knife"].tradeid, knives["skinpeeler knife"].tradecount)
                doPlayerAddItem(cid, knives["skinpeeler knife"].id, 1)
                selfSay('Here are your item.', cid)
                talkState[talkUser] = 0
            else
                selfSay('Sorry, but you don\'t have '..knives["skinpeeler knife"].tradecount..' '..ItemType(knives["skinpeeler knife"].tradeid):getName()..'s.', cid)
                talkState[talkUser] = 0
            end
        else
            selfSay('Okay, see u later.', cid)
            talkState[talkUser] = 0
        end
       
    else
        local str = ''
        for index, result in pairs(knives) do
            str = str.."{"..index.."}, "
        end
        selfSay('Sorry, but have to say a knife name: '..str..'.', cid)
        talkState[talkUser] = 0
    end
  return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())