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
shopModule:addSellableItem({'scimitar'}, 2419, 165, 'scimitar')
shopModule:addSellableItem({'giant sword'}, 2393, 18700, 'giant sword')
shopModule:addSellableItem({'serpent sword'}, 2409, 990, 'serpent sword')
shopModule:addSellableItem({'poison dagger'}, 2411, 55, 'poison dagger')
shopModule:addSellableItem({'knight axe'}, 2430, 2200, 'knight axe')
shopModule:addSellableItem({'dragon hammer'}, 2434, 2200, 'dragon hammer')
shopModule:addSellableItem({'skull staff'}, 2436, 6600, 'skull staff')
shopModule:addSellableItem({'dark armor'}, 2489, 440, 'dark armor')
shopModule:addSellableItem({'knight armor'}, 2476, 5500, 'knight armor')
shopModule:addSellableItem({'dark helmet'}, 2490, 275, 'dark helmet')
shopModule:addSellableItem({'warrior helmet'}, 2475, 5500, 'warrior helmet')
shopModule:addSellableItem({'strange helmet'}, 2479, 550, 'strange helmet')
shopModule:addSellableItem({'mystic turban'}, 2663, 165, 'mystic turban')
shopModule:addSellableItem({'knight legs'}, 2477, 5500, 'knight legs')
shopModule:addSellableItem({'tower shield'}, 2528, 8800, 'tower shield')
shopModule:addSellableItem({'black shield'}, 2529, 880, 'black shield')
shopModule:addSellableItem({'ancient shield'}, 2532, 990, 'ancient shield')
shopModule:addSellableItem({'vampire shield'}, 2534, 16500, 'vampire shield')

shopModule:addBuyableItem({'ice rapier'}, 2396, 4500, 'ice rapier')
shopModule:addBuyableItem({'serpent sword'}, 2409, 5400, 'serpent sword')
shopModule:addBuyableItem({'dark armor'}, 2489, 1350, 'dark armor')
shopModule:addBuyableItem({'dark helmet'}, 2490, 900, 'dark helmet')
shopModule:addBuyableItem({'ancient shield'}, 2532, 4500, 'ancient shield')
npcHandler:addModule(FocusModule:new())