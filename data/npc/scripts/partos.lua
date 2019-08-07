local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local Topic = {}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

if msgcontains(msg:lower(), "prison") then
	npcHandler:say("You mean that's a JAIL? They told me it's the finest hotel in town! THAT explains the lousy roomservice!", cid)
	Topic[cid] = 1
elseif msgcontains(msg, "ankrahmun") and Topic[cid] == 1 then
	npcHandler:say({"Yes, I've lived in Yehsha for quite some time. Ahh, good old times! ...",
					"Unfortunately I had to relocate. <sigh> ...",
					"Business reasons - you know."}, cid)
	Topic[cid] = 2
elseif msgcontains(msg, "supplies") and Topic[cid] == 2 then
	npcHandler:say({"What!? I bet, Baa'leal sent you! ...",
					"I won't tell you anything! Shove off!"}, cid)
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01) == 3 then
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission01, 4)
	end
end
	
	return true
end

-- keywordHandler:addKeyword({'prison'}, StdModule.say, {npcHandler = npcHandler, text = 'You mean that\'s a JAIL? They told me it\'s the finest hotel in town! THAT explains the lousy roomservice!'})
keywordHandler:addKeyword({'jail'}, StdModule.say, {npcHandler = npcHandler, text = 'You mean that\'s a JAIL? They told me it\'s the finest hotel in town! THAT explains the lousy roomservice!'})
keywordHandler:addKeyword({'cell'}, StdModule.say, {npcHandler = npcHandler, text = 'You mean that\'s a JAIL? They told me it\'s the finest hotel in town! THAT explains the lousy roomservice!'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome to my little kingdom, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, visit me again. I will be here, promised.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye, visit me again. I will be here, promised.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
