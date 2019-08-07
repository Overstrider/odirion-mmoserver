local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- [[ START THE SETTINGS ]] ---
local bpList = {
	["elite knight armor"] = {
		price = 1000, -- em gps
		runes = {id = 2476, count = 20},
		name = "Elite Knight Armor",
		bp = 7140,
		},

	["elite knight legs"] = {
		price = 1000, -- em gps
		runes = {id = 2477, count = 20},
		name = "Elite Knight Legs",
		bp = 7141,
		},

		["warlord knight armor"] = {
		price = 10000, -- em gps
		runes = {id = 7140, count = 20},
		name = "Warlord Knight Armor",
		bp = 7142,
		},

		["warlord knight legs"] = {
		price = 10000, -- em gps
		runes = {id = 7141, count = 20},
		name = "Warlord Knight Legs",
		bp = 7143,
		},

}
-- [[ END FROM SETTINGS ]] ---

function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	local get = bpList[msg]
	if get then
		buying = get
		selfSay('Do you really want to trade for the item? '..get.name..' , I need '..get.runes.count..'x '..ItemType(buying.runes.id):getName()..' and '..get.price..' gold coins?', cid)
		talkState[talkUser] = 1
		
		-- [[ CONFIRMANDO COMPRA ]] --
	elseif talkState[talkUser] == 1 then
		if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
			if getPlayerItemCount(cid, buying.runes.id) >= buying.runes.count then
				if doPlayerRemoveMoney(cid, buying.price) then
					doPlayerRemoveItem(cid, buying.runes.id, buying.runes.count)
					doPlayerAddItem(cid, buying.bp)
					selfSay('Congratulations, you bought the '..buying.name..'.', cid)
					talkState[talkUser] = 0
				else
					selfSay('I\'m so sorry, but you don\'t have '..buying.price..' gold coins.', cid)
					talkState[talkUser] = 0
				end
			else
				selfSay('I\'m so sorry, but you don\'t have '..buying.runes.count..'x '..ItemType(buying.runes.id):getName()..'.', cid)				
				talkState[talkUser] = 0
			end
		else
			selfSay('Okay, see u later.', cid)
			talkState[talkUser] = 0
		end	
	end
  return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())