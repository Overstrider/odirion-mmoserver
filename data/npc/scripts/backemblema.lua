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
	["buy uh backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2273, count = 5},
		name = "ultimate healing",
		bp = 5644,
		},

	["buy gfb backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2304, count = 5},
		name = "great fireball",
		bp = 5647,
		},

		["buy sd backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2268, count = 5},
		name = "suddendeath",
		bp = 5645,
		},

		["buy explosion backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2313, count = 5},
		name = "explosion",
		bp = 5650,
		},

		["buy magicwall backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2293, count = 5},
		name = "magicwall",
		bp = 5646,
		},

		["buy hmm backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2311, count = 5},
		name = "heavy magic missile",
		bp = 5649,
		},

		["buy intense healing backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2265, count = 5},
		name = "intense healing",
		bp = 5643,
		},

		["buy adori backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2287, count = 5},
		name = "adori",
		bp = 5642,
		},

		["buy paralyze backpack"] = {
		price = 2000, -- em gps
		runes = {id = 2278, count = 5},
		name = "paralyze",
		bp = 6227,
		},

		["buy demon backpack"] = {
		price = 2000, -- em gps
		runes = {id = 6013, count = 5},
		name = "demon",
		bp = 5614,
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
		selfSay('You really wanna buy a backpack with '..get.name..' emblem for '..get.runes.count..'x '..ItemType(get.runes.id):getName()..' and '..get.price..' gold coins?', cid)
		talkState[talkUser] = 1
		
		-- [[ CONFIRMANDO COMPRA ]] --
	elseif talkState[talkUser] == 1 then
		if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
			if getPlayerItemCount(cid, buying.runes.id) >= buying.runes.count then
				if doPlayerRemoveMoney(cid, buying.price) then
					doPlayerRemoveItem(cid, buying.runes.id, buying.runes.count)
					doPlayerAddItem(cid, buying.bp)
					selfSay('Congratulations, you bought the '..buying.name..' backpack.', cid)
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