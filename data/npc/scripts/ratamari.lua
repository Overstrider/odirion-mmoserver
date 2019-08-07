local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkUser = 0

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
if (msgcontains(msg, "PIEDPIPER") or msgcontains(msg, "piedpiper")) and (not npcHandler:isFocused(cid)) then
	npcHandler:setMaxIdleTime(120)
	npcHandler:say("Meep? I mean - hello! Sorry, player... Being a rat has kind of grown on me.", cid)
	npcHandler:addFocus(cid)
	talkUser = 1
elseif msgcontains(msg, "spy report") and talkUser == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.RataMari) == -1 then
		npcHandler:say({"You have come for the report? Great! I have been working hard on it during the last months. And nobody came to pick it up. I thought everybody had forgotten about me! ...",
						"Do you have any idea how difficult it is to hold a pen when you have claws instead of hands? ...",
						"But - you know - now I have worked so hard on this report I somehow don't want to part with it. Atleast not without some decent payment. ...",
						"All right - listen - I know Fa'hradin would not approve of this, but I can't help it. I need some cheese! I need it now! ...",
						"And I will not give the report to you until you get me some! Meep!",
						"Meep!"}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 3)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.RataMari, 1)
		addEvent(function() npcHandler:setMaxIdleTime(0) end, 10000)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.RataMari) == 1 then
		if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02) == 3 then
			npcHandler:say({"Ok, have you brought me the cheese, I've asked for?"}, cid)
			talkUser = 2
		end
	end
elseif msgcontains(msg, "yes") and talkUser == 2 then
	if doPlayerRemoveItem(cid, 2696, 1) then
		npcHandler:say({"Meep! Meep! Great! Here is the spyreport for you!",
						"Meep!"}, cid)
		doPlayerAddItem(cid, 2345, 1)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 1)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 4)
	end
elseif msgcontains(msg, "bye") then	
	npcHandler:unGreet(cid)	
end
	return true
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "Meep! Meep!")  