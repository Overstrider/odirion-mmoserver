local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end

local talk_user = 0
function creatureSayCallback(cid, type, msg)
if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then
	npcHandler:say("Hey! A human! What are you doing in my kitchen, "..getCreatureName(cid) .."?", cid)
	npcHandler:setMaxIdleTime(120)
	npcHandler:addFocus(cid)
	talk_user = 1
return true
end

if msgcontains(msg, "mission") and getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01) == 1 and talk_user == 1 then
	npcHandler:say({"My collection of recipes is almost complete. There are only but a few that are missing. ...",
					"Hmmm... now that we talk about it. There is something you could help me with. Are you interested?"}, cid)
	talk_user = 2
elseif msgcontains(msg, "yes") and getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01) == 1 and talk_user == 2 then
	npcHandler:say({"Fine! Even though I know so many recipes, I'm looking for the description of some dwarven meals. ...",
					"So, if you could bring me a cookbook of the dwarven kitchen I will reward you well.",
					"Now, where was I?"}, cid)	
	setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01, 2)
	addEvent(function() npcHandler:setMaxIdleTime(0) end, 4000)
elseif msgcontains(msg, "cookbook") and getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01) == 3 and talk_user == 1 then
	npcHandler:say("Do you have the cookbook of the dwarven kitchen with you? Can I have it?", cid)
	talk_user = 3
elseif msgcontains(msg, "yes") and getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01) == 3 and talk_user == 3 then
	if doPlayerRemoveItem(cid, 2347, 1) then
		doPlayerAddItem(cid, 2146, 6)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission01, 4)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 1)
		npcHandler:say({"The book! You have it! Let me see! <browses the book> ...", 
						"Dragon Egg Omelette, Dwarven beer sauce... it's all there. This is great! Here is your well-deserved reward. ...",
						"Incidentally, I have talked to Fa'hradin about you during dinner. I think he might have some work for you. Why don't you talk to him about it?"}, cid)
		addEvent(function() npcHandler:setMaxIdleTime(0) end, 4000)
		talk_user = 1
	else
		npcHandler:say("I dont see any cookbook.", cid)
		talk_user = 1
	end
elseif msgcontains(msg, "bye") then	
	npcHandler:unGreet(cid)	
end
	
return true
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)