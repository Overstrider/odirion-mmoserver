local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end
function greetCallback(cid)
	if getCreatureCondition(cid, CONDITION_POISON) then -- SE ESTIVER CONDITION_POISON
		if getPlayerStorageValue(cid,10051) == -1 then -- SE NÃO TIVER A STORAGE
			npcHandler:say('Begone! Hissssss! You step on the mission tile!')
			return false
		else -- CASO TENHA STORAGE
			doTeleportThing(cid, {x=33397,y=32836,z=14})
			selfSay('Venture the path of decay!')
			return true
		end -- FIM DO GET STORAGE
	else -- CASO NÃO ESTEJA CONDITION_POISON
		npcHandler:say('Begone! Hissssss! You bear not the mark of the cobra!')
		return false
	end -- FIM DO GET CONDITION
end -- FIM DA FUNÇÃO function greetCallback(cid)

-- Set the greeting callback function
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

-- Make it react to hi/bye etc.
npcHandler:addModule(FocusModule:new())