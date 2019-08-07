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

shopModule:addSellableItem({'sword ring'}, 2207, 110, 'sword ring') 
shopModule:addSellableItem({'club ring'}, 2209, 110, 'club ring') 
shopModule:addSellableItem({'axe ring'}, 2208, 110, 'axe ring') 
shopModule:addSellableItem({'power ring'}, 2166, 55, 'power ring') 
shopModule:addSellableItem({'stealth ring'}, 2165, 220, 'stealth ring')
shopModule:addSellableItem({'stone skin amulet'}, 2197, 550, 'stone skin amulet') 
shopModule:addSellableItem({'elven amulet'}, 2198, 110, 'elven amulet') 
shopModule:addSellableItem({'bronze amulet'}, 2172, 55, 'bronze amulet') 
shopModule:addSellableItem({'garlic necklace'}, 2199, 55, 'garlic necklace')  
shopModule:addSellableItem({'magic light wand'}, 2162, 40, 'magic light wand') 
shopModule:addSellableItem({'orb'}, 2176, 825, 'orb') 
shopModule:addSellableItem({'mind stone'}, 2178, 110, 'mind stone') 
shopModule:addSellableItem({'life crystal'}, 2177, 55, 'life crystal') 

shopModule:addBuyableItem({'sword ring'}, 2207, 450, 'sword ring') 
shopModule:addBuyableItem({'club ring'}, 2209,450, 'club ring') 
shopModule:addBuyableItem({'axe ring'}, 2208, 450, 'axe ring') 
shopModule:addBuyableItem({'power ring'}, 2166, 90, 'power ring') 
shopModule:addBuyableItem({'stealth ring'}, 2165, 4500, 'stealth ring')
shopModule:addBuyableItem({'stone skin amulet'}, 2197, 4500, 'stone skin amulet') 
shopModule:addBuyableItem({'elven amulet'}, 2198, 450, 'elven amulet') 
shopModule:addBuyableItem({'bronze amulet'}, 2172, 90, 'bronze amulet') 
shopModule:addBuyableItem({'garlic necklace'}, 2199, 90, 'garlic necklace') 
npcHandler:addModule(FocusModule:new())