  local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = 0
function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end


function creatureSayCallback(cid, type, msg)        
if (msgcontains(msg, "hi") and msgcontains(msg, "maryza")) and (not npcHandler:isFocused(cid)) then
		npcHandler:greet(cid)
		npcHandler:addFocus(cid)
		talkState = 1
	return true
	end
	if(not npcHandler:isFocused(cid)) then
		return false
	end
if msgcontains(msg, "cookbook") then
	if getPlayerStorageValue(cid, 9034) == -1 and talkState == 1 then
		npcHandler:say("Would you like to buy a cookbook for 150 gold?", cid)
		talkState = 2
	else
		npcHandler:say("I just selling one cookbook to each person.", cid)		
	end                                           
end
if msgcontains(msg, "yes") and getPlayerStorageValue(cid, 9034) == -1 and talkState == 2 then
	if doPlayerRemoveMoney(cid, 150) then
		if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01) == 2 then
			setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01, 3)
		end
		npcHandler:say("Here you go.", cid)
		setPlayerStorageValue(cid, 9034, 1)
		doPlayerAddItem(cid, 2347, 1)
	else
		npcHandler:say("The cookbook costs 150 gold.", cid) 
	end
end
if msgcontains(msg, "bye") then	
	npcHandler:unGreet(cid)	
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)