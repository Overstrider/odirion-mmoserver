local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end
 
local c = {
	bp = 20, -- Preço da BP em Gold Coins
	sell = { -- Lista de Runas
		["blank"] = {id = 2260,  price = 10, count = 1, what = "rune"},
		
		["mana"] = {id = 2006,  price = 100, count = 7, what = "fluid"},
		
		["life"] = {id = 2006, price = 60, count = 10, what = "fluid"},
	},
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

	g = c.sell[msg:lower()]
	if g then
		smsg = msg
		found = c.sell[smsg:lower()]
		npcHandler:say('Do you wanna buy BACKPACK of '..smsg..' '..found.what..'(s)?', cid)
		talk_state = 1
		return true
	end
	
	-- [[ BACKPACK OR NOT ]] --
	if talk_state == 1 and msgcontains(msg, 'yes') then
		bp = true
		npcHandler:say('How much Backpack(s) of '..smsg..' you want?', cid)
		talk_state = 2
		return true
	elseif talk_state == 1 and msgcontains(msg, 'no') then
		bp = false
		npcHandler:say('Ok, how much '..smsg..' '..found.what..'(s) you want?', cid)
		talk_state = 2
		return true
	
	-- [[ QUANTIDADE ]] --
	elseif talk_state == 2 then
		n = getNumber(msg)
		if n > 0 then
			cost = (n*found.price)
			if bp then cost = cost + c.bp end
			if bp then s = ' BACKPACK(s) of' else s = '' end
			npcHandler:say('Do you wanna buy '..n..''..s..' '..smsg..' '..found.what..'(s) for '..cost..' gold coins?', cid)
			talk_state = 3
			return true
		else
			npcHandler:say('Please, tell a number value.', cid)
			talk_state = 2
			return true
		end
		
	-- [[ CONFIRMANDO ]] --	
	elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerMoney(cid) >= cost then
			doPlayerRemoveMoney(cid, cost)
			if bp then
				for i = 1, n do
					_bp = doPlayerAddItem(cid, 2000, 1)
                    for a = 1, 20 do
                        doAddContainerItem(_bp, found.id, found.count)
                    end 
				end
			else
				for i = 1, n do
					doPlayerAddItem(cid, found.id, found.count)
				end
			end
			npcHandler:say('Thank you!', cid)
			talk_state = 0
			return true
		else
			npcHandler:say('Sorry, you have money.', cid)
			talk_state = 0
			return true
		end
	
	elseif msgcontains(msg, 'no') and talk_state == 3 then
		npcHandler:say('Ok, then!', cid)
		talk_state = 0
		return true
	end

	if not g then
		local str = ''
		for index, result in pairs(c.sell) do
			if str == '' then
				str = str..""..index.." cost "..result.price.."gps"
			else
				str = str.." and "..index.." cost "..result.price.."gps"
			end
		end
		npcHandler:say('I sell '..str..', you can buy backpacks of items too, ex: bp of blank rune.', cid)
		return true
	end
	
return TRUE
end

function getNumber(txt) --return number if its number and is > 0, else return 0
x = string.gsub(txt,"%a","")
x = tonumber(x)
	if x ~= nill and x > 0 then
		return x
	else
		return 0
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())