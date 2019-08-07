local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
local Topic = {}
function creatureSayCallback(cid, type, msg)

if (msgcontains(msg, "djanni'hah") or msgcontains(msg, "DJANNI'HAH")) and (not npcHandler:isFocused(cid)) then
	npcHandler:say("What do you want from me, "..getCreatureName(cid).."?", cid)
	npcHandler:addFocus(cid)
	Topic[cid] = 1
elseif msgcontains(msg, "mission") and Topic[cid] == 1 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02) == 1 then
		npcHandler:say({"So Baa'leal thinks you are up to do a mission for us? ...",
						"I think he is geting old, entrusting human scum such as you are with an important mission like that. ...",
						"Personally, I don't understand why you haven't been slaughtered right at the gates. ...",
						"Anyway. Are you prepared to embark on a dangerous mission for us?"}, cid)
		Topic[cid] = 2
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02) == 3 then
		npcHandler:say("Did you find the tear of Daraman?", cid)
		Topic[cid] = 2
	end
elseif msgcontains(msg, "yes") and Topic[cid] == 2 then
	if getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02) == 1 then
		npcHandler:say({"All right then, human. Have you ever heard of the 'Tears of Shakirian'? ...",
						"They are precious gemstones made of some unknown blue mineral and possess enormous magical power. ...",
						"If you want to learn more about these gemstones don't forget to visit our library. ...",
						"Anyway, one of them is enough to create thousands of our mighty djinn blades. ...",
						"Unfortunately my last gemstone broke and therefore I'm not able to create new blades anymore. ...",
						"To my knowledge there is only one place where you can find these gemstones - I know for a fact that the Marid have at least one of them. ...",
						"Well... to cut a long story short, your mission is to sneak into Ashta'daramai and to steal it. ...",
						"Needless to say, the Marid won't be too eager to part with it. Try not to get killed until you have delivered the stone to me."}, cid)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02, 2)
		setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
	elseif getPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02) == 3 then
		if doPlayerRemoveItem(cid, 2346, 1) then
			npcHandler:say({"So you have made it? You have really managed to steal a Tear of Daraman? ... Alesar: Amazing how you humans are just impossible to get rid of. Incidentally, you have this character trait in common with many insects and with other vermin. ...", 
							"Nevermind. I hate to say it, but it you have done us a favour, human. That gemstone will serve us well. ...",
							"Baa'leal, wants you to talk to Malor concerning some new mission. ...",
							"Looks like you have managed to extended your life expectancy - for just a bit longer."}, cid)
			setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission02, 4)
			setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.DoorToMaridTerritory, -1)
			setPlayerStorageValue(cid, Storage.DjinnWar.EfreetFaction.Mission03, 1)
		else
			npcHandler:say("I dont see any tear of daraman.", cid)
			Topic[cid] = 1
		end
	end
end
if msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
	npcHandler:unGreet(cid)	
end
return true
end

local function onTradeRequest(cid)
if Player(cid):getStorageValue(Storage.DjinnWar.EfreetFaction.Finish) ~= 1 then
npcHandler:say('I\'m sorry, but you don\'t have Malor\'s permission to trade with me.', cid)
return false
end
	return true
end

npcHandler:setCallback(CALLBACK_ONTRADEREQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, 'What do you want from me, |PLAYERNAME|?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Finally.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Finally.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'At your service, just browse through my wares.')

shopModule:addSellableItem({'scimitar'}, 2419, 150, 'scimitar')
shopModule:addSellableItem({'giant sword'}, 2393, 17000, 'giant sword')
shopModule:addSellableItem({'serpent sword'}, 2409, 900, 'serpent sword')
shopModule:addSellableItem({'poison dagger'}, 2411, 50, 'poison dagger')
shopModule:addSellableItem({'knight axe'}, 2430, 2000, 'knight axe')
shopModule:addSellableItem({'dragon hammer'}, 2434, 2000, 'dragon hammer')
shopModule:addSellableItem({'skull staff'}, 2436, 6000, 'skull staff')
shopModule:addSellableItem({'dark armor'}, 2489, 400, 'dark armor')
shopModule:addSellableItem({'knight armor'}, 2476, 5000, 'knight armor')
shopModule:addSellableItem({'dark helmet'}, 2490, 250, 'dark helmet')
shopModule:addSellableItem({'warrior helmet'}, 2475, 5000, 'warrior helmet')
shopModule:addSellableItem({'strange helmet'}, 2479, 500, 'strange helmet')
shopModule:addSellableItem({'mystic turban'}, 2663, 150, 'mystic turban')
shopModule:addSellableItem({'knight legs'}, 2477, 5000, 'knight legs')
shopModule:addSellableItem({'tower shield'}, 2528, 8000, 'tower shield')
shopModule:addSellableItem({'black shield'}, 2529, 800, 'black shield')
shopModule:addSellableItem({'ancient shield'}, 2532, 900, 'ancient shield')
shopModule:addSellableItem({'vampire shield'}, 2534, 15000, 'vampire shield')

shopModule:addBuyableItem({'ice rapier'}, 2396, 5000, 'ice rapier')
shopModule:addBuyableItem({'serpent sword'}, 2409, 6000, 'serpent sword')
shopModule:addBuyableItem({'dark armor'}, 2489, 1500, 'dark armor')
shopModule:addBuyableItem({'dark helmet'}, 2490, 1000, 'dark helmet')
shopModule:addBuyableItem({'ancient shield'}, 2532, 5000, 'ancient shield')
