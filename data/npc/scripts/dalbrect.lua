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
	
	if msgcontains(msg, 'brooch') then
		npcHandler:say('What? You want me to examine a brooch?', cid)
		talk_state = 1
	elseif msgcontains(msg, 'yes') and talk_state == 1 and getPlayerItemCount(cid,2318) >= 1 then
		npcHandler:say('You have recovered my brooch! I shall forever be in your debt, my friend!', cid)
		doPlayerTakeItem(cid,2318,1)
		setPlayerStorageValue(cid,99999,1)
		talk_state = 2
	elseif msgcontains(msg, 'passage') then
		if getPlayerStorageValue(cid,99999) == 1 then				
			npcHandler:say('Since you are my friend now I will sail you to the isle of the kings for 10 gold. Is that okay for you?', cid)
			talk_state = 3
		else
			npcHandler:say('You are not my friend.', cid)
			talk_state = 0
		end
	elseif msgcontains(msg, 'yes') and talk_state == 3 then
	local player = Player(cid)
	if not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		if getPlayerStorageValue(cid,99999) == 1 then
			if getPlayerMoney(cid) >= 10 then
				selfSay('Have a nice trip!', cid)
				doPlayerRemoveMoney(cid, 10)
				doTeleportThing(cid, {x=32190,y=31957,z=6})
				doSendMagicEffect(getCreaturePosition(cid), 10)
				talk_state = 0
			else
				npcHandler:say('You don\'t have enough money.', cid)
				talk_state = 0
			end
		else
		npcHandler:say('You can\'t travel without my family brooch', cid)
		talk_state = 0
		end
	else
		npcHandler:say('First get rid of those blood stains! You are not going to ruin my vehicle!', cid)
		talk_state = 0
	end
	end
	return true
	end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())