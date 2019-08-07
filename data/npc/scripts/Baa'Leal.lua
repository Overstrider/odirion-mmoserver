local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local Topic = {}
 
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
 
function creatureSayCallback(cid, type, msg)
if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Start) == 1 then
		npcHandler:addFocus(cid)
		npcHandler:say("You know the code human! Very well then... What do you want, "..getCreatureName(cid).."?", cid)
		Topic[cid] = 1
	else
		npcHandler:say("Dont disturb me then.",cid)
	end
elseif msgcontains(msg, "mission") and Topic[cid] == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01) == 1 then
		npcHandler:say({"Each mission and operation is a crucial step towards our victory! ...",
						"Now that we speak of it ...",
						"Since you are no djinn, there is something you could help us with. Are you interested, human?"}, cid)
		Topic[cid] = 2
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01) == 4 then
		npcHandler:say("Did you find the thief of our supplies?", cid)
		Topic[cid] = 2
	end
elseif msgcontains(msg, "yes") and Topic[cid] == 2 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01) == 1 then
		npcHandler:say({"Well ... All right. You may only be a human, but you do seem to have the right spirit. ...",
						"Listen! Since our base of operations is set in this isolated spot we depend on supplies from outside. These supplies are crucial for us to win the war. ...",
						"Unfortunately, it has happened that some of our supplies have disappeared on their way to this fortress. At first we thought it was the Marid, but intelligence reports suggest a different explanation. ...",
						"We now believe that a human was behind the theft! ...",
						"His identity is still unknown but we have been told that the thief fled to the human settlement called Carlin. I want you to find him and report back to me. Nobody messes with the Efreet and lives to tell the tale! ...",
						"Now go! Travel to the northern city Carlin! Keep your eyes open and look around for something that might give you a clue!"}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01, 2)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01) == 4 then
		npcHandler:say("Finally! What is his name then?", cid)
		Topic[cid] = 3
	end
elseif msgcontains(msg, "partos") and Topic[cid] == 3 then
	npcHandler:say({"You found the thief! Excellent work, soldier! You are doing well - for a human, that is. Here - take this as a reward. ...",
					"Since you have proven to be a capable soldier, we have another mission for you. ... Baa'leal: If you are interested go to Alesar and ask him about it."}, cid)
	Topic[cid] = 4
elseif msgcontains(msg, "hail malor") and Topic[cid] == 4 then
	npcHandler:say("Hail to our great leader!", cid)
	setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01, 5)
	setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02, 1)
end
if msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
	npcHandler:say("Hail King Malor! See you on the battlefield, human worm.",cid)
	npcHandler:releaseFocus(cid)
	npcHandler:resetNpc(cid)
	Topic[cid] = 0
end	

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)