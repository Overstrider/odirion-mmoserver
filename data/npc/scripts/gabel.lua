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
	npcHandler:say("Welcome, human "..getCreatureName(cid)..", to our humble abode.", cid)
	npcHandler:addFocus(cid)
	talkState = 1

elseif msgcontains(msg, "mission") and talkState == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03) == 1 then
		npcHandler:say({"Sooo. Fa'hradin has told me about your extraordinary exploit, and I must say I am impressed. ...",
						"Your fragile human form belies your courage and your fighting spirit. ...",
						"I hardly dare to ask you because you have already done so much for us, but there is a task to be done, and I cannot think of anybody else who would be better suited to fulfill it than you. ...",
						"Think carefully, human, for this mission will bring you into real danger. Are you prepared to do us that final favour?"}, cid)
		talkState = 2
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03) == 4 then 
		npcHandler:say("Have you found Fa'hradin's lamp and placed it in Malor's personal chambers?", cid)
		talkState = 2
	end
		
	
elseif msgcontains(msg, "yes") and talkState == 2 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03) == 1 then
		npcHandler:say({"All right. Listen! Thanks to Rata'mari's report we now know what Malor is up to: he wants to do to me what Ihave done to him - he wants to imprison me in Fa'hradin's lamp! ...",
						"Of course, that won't happen. Now, we know his plans. ...",
						"But I am aiming at something different. We have learnt one important thing: At this point of time, Malor does not have the lamp yet, which means it is still where he left it. We need that lamp! If we get it back we can imprison him again! ...",
						"From all we know the lamp is still in the Orc King's possession! Therefore I want to ask you to enter thewell guarded halls over at Ulderek's Rock and find the lamp. ...",
						"Once you have acquired the lamp you must enter Mal'ouquah again. Sneak into Malor's personal chambersand exchange his sleeping lamp with Fa'hradin's lamp! ...",
						"If you succeed, the war could be over one night later! I and all djinn will be in your debt forever! May Shakirian watch over you!"}, cid)
		talkState = 3
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03, 2)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03) == 4 then
		npcHandler:say({"Shakirian shall bless you and all humans! You have done us all a huge service! Soon, this awful war will be over! ...", 
						"Know, that from now on you are considered one of us and are welcome to trade with {Haroun} and {Nah'bob} whenever you want to!",
						"Farewell, stranger. May Uman open your minds and your hearts to Shakirian's wisdom!"}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Finish, 1)
	end
elseif msgcontains(msg, "orc king?") and talkState == 3 then
	npcHandler:say({"The power hungry fool released Malor from his prison, and now the evil is upon us once again! He shouldhave known better than to believe Malor's sugar covered lies. ...",
							"But what can you expect from a power-crazed, stupid-as-a-brick orc. Nothing but blockheads the lot of them."}, cid)
	setPlayerStorageValue(cid, Storage.DjinnWar.MaridFaction.Mission03, 2)
	setPlayerStorageValue(cid, Storage.DjinnWar.ReceivedLamp, 1)

elseif msgcontains(msg, "bye") then	
	npcHandler:unGreet(cid)	
end						

   return true
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)  
npcHandler:setMessage(MESSAGE_WALKAWAY, "How rude!")