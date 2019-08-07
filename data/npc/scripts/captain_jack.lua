local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, 'continent') or msgcontains(msg, 'tibia') then
	npcHandler:say('Friends of Dalbrect are my friends too! So you are looking for a passage to the continent for 20 gold?', cid)
	talk_state = 1

	elseif msgcontains(msg,'yes') and talk_state == 1 then
	if getPlayerStorageValue(cid, 99998) == -1 then
		if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
			if getPlayerMoney(cid) >= 20 then
				selfSay('Have a nice trip!', cid)
				doPlayerRemoveMoney(cid, 20)
				doTeleportThing(cid, {x=32205,y=31756,z=6})
				doSendMagicEffect(getCreaturePosition(cid), 10)
				talk_state = 0
			else
				npcHandler:say('You don\'t have enough money.', cid)
				talk_state = 0
			end
		else
			npcHandler:say('First get rid of those blood stains! You are not going to ruin my vehicle!', cid)
			talk_state = 0
		end
	else
	npcHandler:say('Without the abbots permission I won\'t take sail you anywhere! Go and ask him for a passage first.', cid)
	talk_state = 0
	end
end
		
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())