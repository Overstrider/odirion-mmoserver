local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
------------------- CONFIGURATION --------------
local msg_citiesfree = 'Carlin, Ab\'Dendriel, Thais, Venore, Edron and Thule' -- Cidades para Free Account
local msg_citiespremmy = 'Carlin, Ab\'Dendriel, Thais, Venore, Edron and Thule' -- Cidades para Premium Account
local travels = {
	["thule"] = {destiny = {x=32983, y=31368, z=6}, cost = 5000, level = 1, premmy = false},
	-- Thule
	["ab'dendriel"] = {destiny = {x=32734, y=31668, z=6}, cost = 130, level = 1, premmy = false},
	["venore"] = {destiny = {x=32954, y=32022, z=6}, cost = 170, level = 1, premmy = false},
	["carlin"] = {destiny = {x=32387, y=31820, z=6}, cost = 110, level = 1, premmy = false},
	-- PREMIUM
	["edron"] = {destiny = {x=33175, y=31764, z=6}, cost = 160, level = 1, premmy = true},
}
------------------ MESSAGENS --------------------------
	local player = Player(cid)
	travel = travels[string.lower(msg)]
	if travel and string.lower(msg) ~= "thule" then
		custo = travel.cost
		destino = travel.destiny
		nivel = travel.level
		if player:getLevel() >= nivel then
			if player:isPremium() then
				selfSay('Do you wanna go to '..msg..' for '..custo..'gps?', cid)
				talkState[talkUser] = 2
			else
				if travel.premmy == true then
					selfSay('I\'m so sorry, but '..msg..' is just for Premium Account.', cid)
					talkState[talkUser] = 0
				else
					selfSay('Do you wanna go to '..msg..' for '..custo..'gps?', cid)
					talkState[talkUser] = 2
				end
			end
		else
			selfSay('I\'m so sorry, u need level '..nivel..' or above for travel.', cid)
			talkState[talkUser] = 0
		end
		
	elseif travel and string.lower(msg) == "thule" then
		custo = travel.cost
		destino = travel.destiny
		nivel = travel.level
		gthule = ''
		if player:getLevel() >= nivel then
			if player:getItemCount(7500) >= 1 then
				gthule = 'scroll'
				npcHandler:addFocus(cid)
				local item = ItemType(7500)
				ticket = item:getName()
				selfSay('You are sure that you wanna go to Thule payin\' a '..ticket..'?.', cid)
				talkState[talkUser] = 4
			else
				if player:getMoney() >= custo then
					gthule = 'money'
					npcHandler:addFocus(cid)
					selfSay('You are sure that you wanna go to Thule payin\' '..custo..'gps?.', cid)
					talkState[talkUser] = 4
				else
					selfSay('Sorry, you don\'t have thule passage scroll or money enough.', cid)
					talkState[talkUser] = 0
				end
			end
		else
			selfSay('I\'m so sorry, u need level '..nivel..' or above for travel.', cid)
			talkState[talkUser] = 0
		end
	
	elseif (msgcontains(msg, 'help') or msgcontains(msg, 'ajuda')) then
		if isPremium(cid) then
			selfSay('Passages to '..msg_citiespremmy..'.', cid)
			talkState[talkUser] = 0
		else
			selfSay('Passages to '..msg_citiesfree..'.', cid)
			talkState[talkUser] = 0
		end
		
	elseif talkState[talkUser] == 2 then -- Confirmando Viagem
		if (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
			if player:removeMoney(custo) then
				player:teleportTo(destino)
				selfSay('See you later.', cid)
				return true
			else
				selfSay('Sorry, you don\'t have money enough.', cid)
				talkState[talkUser] = 0
				return true
			end
		else
			selfSay('Okay, see you later.', cid)
			talkState[talkUser] = 0
		end
		
	elseif talkState[talkUser] == 4 then -- Confirmando Viagem para THULE
		if gthule == 'money' then
			if player:removeMoney(custo) then
				player:teleportTo(destino)
				selfSay('See you later.', cid)
				return true
			else
				selfSay('Sorry, you don\'t have money enough.')
				talkState[talkUser] = 0
				return true
			end
		else
			if player:getItemCount(7500) >= 1 then
				player:removeItem(7500, 1)
				player:teleportTo(destino)
				selfSay('See you later.', cid)
				return true
			else
				selfSay('Sorry, you don\'t have thule passage scroll.', cid)
				talkState[talkUser] = 0
				return true
			end
		end

	else
		if isPremium(cid) then
			selfSay('Please tell a town name: '..msg_citiespremmy..'.', cid)
			talkState[talkUser] = 0
		else
			selfSay('Please tell a town name: '..msg_citiesfree..'.', cid)
			talkState[talkUser] = 0
		end
	end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function getNumber(txt) --return number if its number and is > 0, else return 0
x = string.gsub(txt,"%a","")
x = tonumber(x)
	if x ~= nill and x > 0 then
		return x
	else
		return 0
	end
end