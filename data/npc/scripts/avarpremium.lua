local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

local price = 45000

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'time') then
		local time = getTibiaTime()
		npcHandler:say('It is '.. time.hours .. string.char(58) .. time.minutes ..', right now.')
	end
	if(getPlayerStorageValue(cid, 4523987) == 1) then
		if msgcontains(msg, 'bless') or msgcontains(msg, 'all') or msgcontains(msg, 'blessing') then
			if isPremium(cid) then
				if(not doPlayerRemoveMoney(cid, price)) then
					npcHandler:say("You don't have enough money for blessing, all blessings will cost "..price.." gold coins.", cid)
				else
					for x = 1, 5 do
						doPlayerAddBlessing(cid, x)
					end
					npcHandler:say("You have been blessed by all Gods!", cid)
				end
			else
				npcHandler:say("Sorry, but this blessings is only for Premium Accounts!", cid)
			end
		else
			npcHandler:say("You do not have permission to buy blessing!", cid)
		end
	else
		npcHandler:say("You do not have permission to buy blessing!", cid)
	end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())