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
	["conjure great fireball tri"] = {
		price = 1500, -- em gps
		runes = {id = 7134, count = 10},
		name = "conjure great fireball tri",
		bp = 7421,
		},

	["hunter hood"] = {
		price = 500, -- em gps
		runes = {id = 7134, count = 10},
		name = "Hunter Hood",
		bp = 7433,
		},

	["envenomed crossbow"] = {
		price =350, -- em gps
		runes = {id = 7134, count = 8},
		name = "Envenomed Crossbow",
		bp = 5651,
		},

	["flaming bow"] = {
		price = 250, -- em gps
		runes = {id = 7134, count = 7},
		name = "Flaming Bow",
		bp = 5654,
		},

	["poisoned bow"] = {
		price = 200, -- em gps
		runes = {id = 7134, count = 5},
		name = "Poisoned Bow",
		bp = 5656,
		},

	["conjure explosion tri"] = {
		price = 200, -- em gps
		runes = {id = 7134, count = 5},
		name = "conjure explosion tri",
		bp = 7425,
		},

	["conjure bolt tri"] = {
		price = 100, -- em gps
		runes = {id = 7134, count = 3},
		name = "conjure bolt tri",
		bp = 7422,
		},
	["conjure arrow tri"] = {
		price = 10, -- em gps
		runes = {id = 7134, count = 1},
		name = "conjure arrow tri",
		bp = 7424,
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
		selfSay('Do you really want to trade Hunter Tokens for the item? '..get.name..' , I need '..get.runes.count..'x '..ItemType(get.runes.id):getName()..' and '..get.price..' gold coins?', cid)
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
				selfSay("I\'m so sorry, but you don\'t have "..buying.runes.count.."x "..ItemType(buying.runes.id):getName()..".", cid)
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