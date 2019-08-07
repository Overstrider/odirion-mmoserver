local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local talk_state = 0

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, 'hugo') and talk_state == 0 then
		if getPlayerStorageValue(cid, Storage.ParadoxTower.Hugo) == -1 then
			npcHandler:say("Ah, the curse of the Plains of Havoc, the hidden beast, the unbeatable foe. I've been living here for years and I'm sure this is only a {myth}.", cid)
			talk_state = 1
		else
			npcHandler:say("Ah, the curse of the", cid)
			talk_state = 0
		end
	elseif msgcontains(msg, "myth") and talk_state == 1 then
		npcHandler:say("There are many tales about the fearsome Hugo. It's said it's an abnormality, accidentally created by {Yenny the Gentle}. It's half demon, half something else and people say it's still alive after all these years.", cid)
		talk_state = 2
	elseif msgcontains(msg, "yenny the gentle") and talk_state == 2 then
		npcHandler:say("Yenny, known as the Gentle, was one of the most powerful wielders of magic in ancient times. She was known throughout the world for her mercy and kindness.", cid)
		talk_state = 0
		setPlayerStorageValue(cid, Storage.ParadoxTower.Hugo, 1)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())