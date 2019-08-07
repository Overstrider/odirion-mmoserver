local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = 0
function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end
function creatureSayCallback(cid, type, msg)  
if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then	 
	npcHandler:say("Aaaah... what have we here. A human - interesting. And such an ugly specimen, too... All right, human player. How can I help you?", cid)
	npcHandler:addFocus(cid)
	talkState = 1
elseif msgcontains(msg, "mission") and talkState == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02) == 1 then
		npcHandler:say({"I have heard some good things about you from Bo'ques. But I don't know. ...", 
						"Well, all right. I do have a job for you. ...",
						"In order to stay informed about our enemy's doings, we have managed to plant a spy in Mal'ouquah. ...",
						"He has kept the Efreet and Malor under surveillance for quite some time. ...",
						"But unfortunately, I have lost contact with him months ago. ...",
						"I do not fear for his safety because his cover is foolproof, but I cannot contact him either. This is where you comein. ...",
						"I need you to infiltrate Mal'ouqhah, contact our man there and get his latest spyreport. The password is {PIEDPIPER}. Remember it well! ...",
						"I do not have to add that this is a dangerous mission, do I? If you are discovered expect to be attacked! So goodluck, human!"}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 2)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.DoorToEfreetTerritory, 1)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02) == 4 then
		npcHandler:say("Did you already retrieve the spyreport?", cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 4)
		talkState = 2	
	end
elseif msgcontains(msg, "yes") and talkState == 2 then
	if doPlayerRemoveItem(cid, 2345, 1) then
		npcHandler:say({"You really have made it? You have the report? How come you did not get slaughtered? I must say I'm impressed. Your race will never cease to surprise me. ...",
						"Well, let's see. ...",
						"I think I need to talk to Gabel about this. I am sure he will know what to do. Perhaps you should have aword with him, too."}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission02, 5)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03, 1)
	else
		npcHandler:say("I dont see any spyreport.", cid)
		talk_user = 1
	end
elseif msgcontains(msg, "bye") then	
	npcHandler:unGreet(cid)	
end
return true  
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, human.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "How rude!")