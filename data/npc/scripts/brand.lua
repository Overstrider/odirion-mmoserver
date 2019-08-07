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
shopModule:addSellableItem({'scimitar'}, 2419, 150, 'scimitar')
shopModule:addSellableItem({'giant sword'}, 2429, 250, 'barbarian axe')
shopModule:addSellableItem({'serpent sword'}, 2409, 900, 'serpent sword')
shopModule:addSellableItem({'poison dagger'}, 2411, 50, 'poison dagger')

shopModule:addBuyableItem({'serpent sword'}, 2409, 2000, 'serpent sword')
shopModule:addBuyableItem({'barbarian axe'}, 2429, 1000, 'barbarian axe')
shopModule:addBuyableItem({'plate armor'}, 2463, 600, 'plate Armor')
shopModule:addBuyableItem({'plate legs'}, 2647, 600, 'plate legs')
shopModule:addBuyableItem({'steel helmet'}, 2457, 500, 'steel helmet')
shopModule:addBuyableItem({'clerical mace'}, 2423, 500, 'clerical mace')
shopModule:addBuyableItem({'dwarven shield'}, 2525, 300, 'dwarven shield')
shopModule:addBuyableItem({'scarf'}, 2661, 15, 'scarf')
npcHandler:addModule(FocusModule:new())