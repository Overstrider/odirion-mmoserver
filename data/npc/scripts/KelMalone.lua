local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- [[ START THE SETTINGS ]] ---
local bowList = {
	storage = {key = 99999, value = 1}, -- Storage Necessária
	["enchant bow"] = {
		id = 7095, -- ID da Nova Bow
		price = 3000, -- em Gold Coins or 0
		trade = { -- Lista de Items para Troca
			{id = 2546, count = 500},
			{id = 2147, count = 10},
			{id = 2456, count = 3},
			},
		},
}

-- [[ END FROM SETTINGS ]] ---

function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	player = Player(cid)
	if player:getStorageValue(bowList.storage.key) < bowList.storage.value then
		npcHandler:say('Sorry, but you don\'t have permission to talk to me.', cid)
	return true
	end
	local get = bowList[msg:lower()]
	if get then
		list = get
		tradelist = getTradeBowList(cid, get.trade, get.price)
		npcHandler:say('Do you really want to trade '..tradelist..' for a(n) '..msg..'?', cid)
		talkState[talkUser] = 1
		
		-- [[ CONFIRMANDO COMPRA ]] --
	elseif talkState[talkUser] == 1 then
		if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
			if player:getMoney() < list.price then
				npcHandler:say('Sorry, you don\'t have '..list.price..' gold coins.', cid)
				talkState[talkUser] = 0
				return true
			end
			n = checkTradeBowItemList(player, list)
			if n then
				doRemoveTradeBowItemList(cid, list)
				player:addItem(list.id, 2000)
				npcHandler:say('Congratulations, you bought the '..ItemType(list.id):getName()..'.', cid)
				talkState[talkUser] = 0
			else
				npcHandler:say('I\'m so sorry, but you don\'t have all required items.', cid)
				talkState[talkUser] = 0
			end
		else
			npcHandler:say('Okay, see u later.', cid)
			talkState[talkUser] = 0
		end	
	end
  return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function checkTradeBowItemList(cid, list)
	player = Player(cid)
	ctrl = 0
	for a = 1, #list.trade do
		if player:getItemCount(list.trade[a].id) >= list.trade[a].count then
			ctrl = ctrl + 1
		else
			fail = ''..list.trade[a].count..'x '..ItemType(list.trade[a].id):getName()..''
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You don't have "..fail..".")
		end
	end
	if ctrl == #list.trade then
		return true
	end
end

function doRemoveTradeBowItemList(cid, list)
	for a = 1, #list.trade do
		if player:getItemCount(list.trade[a].id) >= list.trade[a].count then
			player:removeItem(list.trade[a].id, list.trade[a].count)
		end
	end
end

function getTradeBowList(cid, list, price)
	local awardList = ''
	if price > 0 then
		awardList = ''..price..' gold coins and '
	end
	for a = 1, #list do
		if a < (#list-1) then sep = "," else sep = " and" end
		if list[a].count <= 1 then
			temp = list[a].count.."x "..ItemType(list[a].id):getName()..""..sep.." "
		else
			temp = list[a].count.."x "..ItemType(list[a].id):getPluralName()..""..sep.." "
		end			
		awardList = awardList..""..temp..""
		if a == #list then
			cawardList = awardList:sub(1, (#awardList-5))
			awardList = cawardList..""
		end
	end
return awardList
end