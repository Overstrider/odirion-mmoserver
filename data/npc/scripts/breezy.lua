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
shopModule:addSellableItem({'might ring'}, 2164, 275, 'might ring') 
shopModule:addSellableItem({'energy ring'}, 2167, 110, 'energy ring') 
shopModule:addSellableItem({'life ring'}, 2168, 55, 'life ring') 
shopModule:addSellableItem({'time ring'}, 2169, 110, 'time ring') 
shopModule:addSellableItem({'dwarven ring'}, 2213, 110, 'dwarven ring')
shopModule:addSellableItem({'ring of healing'}, 2214, 110, 'ring of healing') 
shopModule:addSellableItem({'strange talisman'}, 2161, 55, 'strange talisman') 
shopModule:addSellableItem({'silver amulet'}, 2170, 55, 'silver amulet') 
shopModule:addSellableItem({'protection amulet'}, 2200, 110, 'protection amulet')  
shopModule:addSellableItem({'dragon necklace'}, 2201, 110, 'dragon necklace') 
shopModule:addSellableItem({'ankh'}, 2193, 1110, 'ankh') 
shopModule:addSellableItem({'mysterious fetish'}, 2194, 55, 'mysterious fetish') 


shopModule:addBuyableItem({'might ring'}, 2164, 4500, 'might ring') 
shopModule:addBuyableItem({'energy ring'}, 2167, 1800, 'energy ring') 
shopModule:addBuyableItem({'life ring'}, 2168, 810, 'life ring') 
shopModule:addBuyableItem({'time ring'}, 2169, 1800, 'time ring') 
shopModule:addBuyableItem({'dwarven ring'}, 2213, 1800, 'dwarven ring')
shopModule:addBuyableItem({'ring of healing'}, 2214, 1800, 'ring of healing') 
shopModule:addBuyableItem({'strange talisman'}, 2161, 90, 'strange talisman') 
shopModule:addBuyableItem({'silver amulet'}, 2170, 90, 'silver amulet')
shopModule:addBuyableItem({'protection amulet'}, 2200, 630, 'protection amulet')
shopModule:addBuyableItem({'dragon necklace'}, 2201, 900, 'dragon necklace')
npcHandler:addModule(FocusModule:new())