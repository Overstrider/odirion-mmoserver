local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
Topic = {}
-- npcHandler:setMessage(MESSAGE_GREET, "Greetings, human |PLAYERNAME|. My patience with your kind is limited, so speak quickly and choose your words well.")
-- npcHandler:setMessage(MESSAGE_PLACEDINQUEUE, "It might have escaped your limited human perception, but I am already talking to somebody else.")
-- npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, human.")
-- npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, human. When I have taken my rightful place I shall remember those who served me well. Even if they are only humans.")

function onCreatureAppear(cid)                  npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)               npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                                              npcHandler:onThink()    end
 
function creatureSayCallback (cid, type, msg)
if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then
	npcHandler:say("Greetings, human "..getCreatureName(cid)..". My patience with your kind is limited, so speak quickly and choose your words well.", cid)
	npcHandler:addFocus(cid)
	Topic[cid] = 1
elseif msgcontains(msg, "mission") and Topic[cid] == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03) == 1 then
		npcHandler:say({"I guess this is the first time I entrust a human with a mission. And such an important mission, too. But well, we live in hard times, and I am a bit short of adequate staff. ...",
						"Besides, Baa'leal told me you have distinguished yourself well in previous missions, so I think you might be the right person for the job. ...",
						"But think carefully, human, for this mission will bring you close to certain death. Are you prepared to embark on this mission?"}, cid)
		Topic[cid] = 2
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03) == 4 then
		npcHandler:say("Have you found Fa'hradin's lamp and placed it in Malor's personal chambers?", cid)
		Topic[cid] = 2
	end
elseif msgcontains(msg, "yes") and Topic[cid] == 2 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03) == 1 then
		npcHandler:say({"Well, listen. We are trying to acquire the ultimate weapon to defeat Gabel: Fa'hradin's lamp! ...", 
						"At the moment it is still in the possession of that good old friend of mine, the Orc King, who kindly released me from it. ...",
						"However, for some reason he is not as friendly as he used to be. You better watch out, human, because I don't think you will get the lamp without a fight. ...",
						"Once you have found the lamp you must enter Ashta'daramai again. Sneak into Gabel's personal chambers and exchange his sleeping lamp with Fa'hradin's lamp! ...",
						"If you succeed, the war could be over one night later!"}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03, 2)
		setPlayerStorageValue(cid, Storage.DjinnWar.ReceivedLamp, 1)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03) == 4 then
		npcHandler:say({"Well well, human. So you really have made it - you have smuggled the modified lamp into Gabel's bedroom! ...",
						"I never thought I would say this to a human, but I must confess I am impressed. ...",
						"Perhaps I have underestimated you and your kind after all. ...",
						"I guess I will take this as a lesson to keep in mind when I meet you on the battlefield. ...",
						"But that's in the future. For now, I will confine myself to give you the permission to trade with my people whenever you want to. ..."}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03, 5)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, -1)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Finish, 1)
	end
end
if msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
	npcHandler:unGreet(cid)	
end				
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)