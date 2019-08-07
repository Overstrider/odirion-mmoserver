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
shopModule:addSellableItem({'dragon lance'}, 2414, 9900, 'dragon lance')
shopModule:addSellableItem({'fire axe'}, 2432, 8800, 'fire axe')
shopModule:addSellableItem({'fire sword'}, 2392, 4400, 'fire sword')
shopModule:addSellableItem({'war hammer'}, 2391, 1320, 'war hammer')
shopModule:addSellableItem({'spike sword'}, 2383, 1100, 'spike sword')
shopModule:addSellableItem({'ice rapier'}, 2396, 1100, 'ice rapier')
shopModule:addSellableItem({'broad sword'}, 2413, 550, 'broad sword')
shopModule:addSellableItem({'obsidian lance'}, 2425, 550, 'obsidian lance')
shopModule:addSellableItem({'crown armor'}, 2487, 13200, 'crown armor')
shopModule:addSellableItem({'blue robe'}, 2656, 11000, 'blue robe')
shopModule:addSellableItem({'noble armor'}, 2486, 990, 'noble armor')
shopModule:addSellableItem({'royal helmet'}, 2498, 33000, 'royal helmet')
shopModule:addSellableItem({'crusader helmet'}, 2497, 6600, 'crusader helmet')
shopModule:addSellableItem({'crown helmet'}, 2491, 2750, 'crown helmet')
shopModule:addSellableItem({'crown legs'}, 2488, 13200, 'crown legs')
shopModule:addSellableItem({'boots of haste'}, 2195, 33000, 'boots of haste')
shopModule:addSellableItem({'phoenix shield'}, 2539, 17600, 'phoenix shield')
shopModule:addSellableItem({'crown shield'}, 2519, 8800, 'crown shield')
shopModule:addSellableItem({'dragon shield'}, 2516, 4400, 'dragon shield')
shopModule:addSellableItem({'guardian shield'}, 2515, 2200, 'guardian shield')
shopModule:addSellableItem({'beholder shield'}, 2518, 1320, 'beholder shield')

shopModule:addBuyableItem({'war hammer'}, 2391, 9000, 'war hammer')
shopModule:addBuyableItem({'spike sword'}, 2383, 7200, 'spikesword')
shopModule:addBuyableItem({'noble armor'}, 2486, 7200, 'noble armor')
shopModule:addBuyableItem({'beholder shield'}, 2518, 6300, 'beholder shield')
npcHandler:addModule(FocusModule:new())