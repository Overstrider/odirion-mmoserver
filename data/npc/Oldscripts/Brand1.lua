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
shopModule:addSellableItem({'giant sword'}, 2393, 17000, 'giant sword')
shopModule:addSellableItem({'serpent sword'}, 2409, 900, 'serpent sword')
shopModule:addSellableItem({'poison dagger'}, 2411, 50, 'poison dagger')

shopModule:addBuyableItem({'Serpent Sword'}, 2409, 2000, 'Serpent Sword')
shopModule:addBuyableItem({'Barbarian Axe'}, 2429, 1000, 'Barbarian Axe')
shopModule:addBuyableItem({'Plate Armor'}, 2463, 600, 'Plate Armor')
shopModule:addBuyableItem({'Plate Legs'}, 2647, 600, 'Plate Legs')
shopModule:addBuyableItem({'Steel Helmet'}, 2457, 500, 'Steel helmet')
shopModule:addBuyableItem({'Clerical Mace'}, 2423, 500, 'Clerical Mace')
shopModule:addBuyableItem({'Dwarven Shield'}, 2525, 300, 'Dwarven Shield')
shopModule:addBuyableItem({'Scarf'}, 2661, 15, 'Scarf')
npcHandler:addModule(FocusModule:new())